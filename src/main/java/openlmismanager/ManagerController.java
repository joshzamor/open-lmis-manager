package openlmismanager;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.io.IOException;

@Controller
public class ManagerController {

    private boolean isLocked;

    public ManagerController() {
        isLocked = false;
    }

    @RequestMapping(value="/", method=RequestMethod.GET)
    public String index() {
        return "index";
    }

    @RequestMapping(value="/db/reset", method=RequestMethod.GET)
    public String databaseReset() {
        if( isLocked == true )
            return "busy";
        isLocked = true;
        try {
            Process p = new ProcessBuilder("./resetDb.sh").start();
            if (p == null || p.waitFor() != 0)
                throw new RuntimeException("error: " + p.exitValue());
        } catch(InterruptedException ie) {
            throw new RuntimeException("Thread interrupted", ie);
        } catch(IOException ioe) {
            throw new RuntimeException("something went wrong", ioe);
        } finally {
            isLocked = false;
        }

        return "success";
    }
}
