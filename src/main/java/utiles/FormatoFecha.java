package utiles;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/* @author Germán Montalbetti © <gmontalbetti@prodismo.com> */
public class FormatoFecha {

    public static String formaFecha() {

            DateFormat df = new SimpleDateFormat("dd/MM/yyy HH:mm:ss");
            Date today = Calendar.getInstance().getTime();
            String reportDate = df.format(today);
            return reportDate;
    }
}    
