package com.cooperative.resources.database;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

@WebListener
public class DatabaseInitializer implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {

        try (
            Connection conn = getConnection();
            Statement st = conn.createStatement()
        ) {

            /* ==========================================
               CLIENT
            ========================================== */
            st.executeUpdate(
                "CREATE TABLE IF NOT EXISTS client ("
              + "idcli INT PRIMARY KEY AUTO_INCREMENT,"
              + "nom VARCHAR(100) NOT NULL,"
              + "numtel VARCHAR(30) NOT NULL"
              + ") ENGINE=InnoDB"
            );

            /* ==========================================
               VOITURE
            ========================================== */
            st.executeUpdate(
                "CREATE TABLE IF NOT EXISTS voiture ("
              + "idvoit VARCHAR(20) PRIMARY KEY,"
              + "design VARCHAR(100) NOT NULL,"
              + "type ENUM('simple','premium','VIP') NOT NULL,"
              + "nbrplace INT NOT NULL,"
              + "frais INT NOT NULL"
              + ") ENGINE=InnoDB"
            );

            /* ==========================================
               PLACE
               clé primaire composite
            ========================================== */
            st.executeUpdate(
                "CREATE TABLE IF NOT EXISTS place ("
              + "idvoit VARCHAR(20) NOT NULL,"
              + "place INT NOT NULL,"
              + "occupation ENUM('oui','non') DEFAULT 'non',"

              + "PRIMARY KEY(idvoit, place),"

              + "CONSTRAINT fk_place_voiture "
              + "FOREIGN KEY(idvoit) "
              + "REFERENCES voiture(idvoit) "
              + "ON DELETE CASCADE "
              + "ON UPDATE CASCADE"

              + ") ENGINE=InnoDB"
            );

            /* ==========================================
               RESERVER
            ========================================== */
            st.executeUpdate(
                "CREATE TABLE IF NOT EXISTS reserver ("

              + "idreserv VARCHAR(20) PRIMARY KEY,"

              + "idvoit VARCHAR(20) NOT NULL,"
              + "idcli INT NOT NULL,"
              + "place INT NOT NULL,"

              + "date_reserv DATETIME NOT NULL,"
              + "date_voyage DATE NOT NULL,"

              + "payment ENUM("
              + "'sans avance',"
              + "'avec avance',"
              + "'tout payé'"
              + ") NOT NULL,"

              + "montant_avance INT DEFAULT 0,"

              + "CONSTRAINT fk_reserver_voiture "
              + "FOREIGN KEY(idvoit) "
              + "REFERENCES voiture(idvoit) "
              + "ON DELETE CASCADE "
              + "ON UPDATE CASCADE,"

              + "CONSTRAINT fk_reserver_client "
              + "FOREIGN KEY(idcli) "
              + "REFERENCES client(idcli) "
              + "ON DELETE CASCADE "
              + "ON UPDATE CASCADE,"

              + "CONSTRAINT fk_reserver_place "
              + "FOREIGN KEY(idvoit, place) "
              + "REFERENCES place(idvoit, place) "
              + "ON DELETE CASCADE "
              + "ON UPDATE CASCADE"

              + ") ENGINE=InnoDB"
            );

            System.out.println("✔ Base cooperative_manager initialisée avec succès.");

        } catch (Exception e) {

            System.err.println("❌ Erreur initialisation base");
            e.printStackTrace();
        }
    }

    /* ==========================================
       CONNEXION MYSQL
    ========================================== */
    public static Connection getConnection() throws Exception {

        String url =
            "jdbc:mysql://localhost:3306/cooperative_manager"
          + "?serverTimezone=UTC"
          + "&useSSL=false"
          + "&allowPublicKeyRetrieval=true";

        String user = "coop";
        String pass = "1234";

        Class.forName("com.mysql.cj.jdbc.Driver");

        return DriverManager.getConnection(url, user, pass);
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println("🔴 Application arrêtée.");
    }
}