package System;
import Database.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.PreparedStatement;
import jakarta.servlet.http.*;

@WebServlet("/admin-change-profile")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize = 5 * 1024 * 1024,
    maxRequestSize = 10 * 1024 * 1024
)
public class AdminChangeProfile extends HttpServlet {
    protected static String UPLOADDIR = "Assets/Profile/Admin";
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("email") == null) {
            response.sendRedirect("Login.jsp");
            return;
        }
        
        String email = (String) session.getAttribute("email");
        Part filePart = request.getPart("photo");

        if (filePart == null || filePart.getSize() == 0) {
            response.sendRedirect("UbahFotoProfileAgency.jsp");
            return;
        }

        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String extension = fileName.substring(fileName.lastIndexOf("."));
        String newFileName = "Admin-" + System.currentTimeMillis() + extension;

        String appPath = request.getServletContext().getRealPath("");
        String uploadPath = appPath + File.separator + UPLOADDIR;

        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        filePart.write(uploadPath + File.separator + newFileName);
        String photoPath = UPLOADDIR + "/" + newFileName;

        try (Connection connect = DBConnection.getConnection()) {
            PreparedStatement state = connect.prepareStatement(
                "UPDATE users SET profileImage=? WHERE email=?"
            );
            state.setString(1, photoPath);
            state.setString(2, email);
            state.executeUpdate();

            session.setAttribute("photo", photoPath);
            response.sendRedirect("admin-profile");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("UbahFotoProfileAdmin.jsp");
        }
    }
}
