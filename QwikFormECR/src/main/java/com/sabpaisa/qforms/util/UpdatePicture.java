package com.sabpaisa.qforms.util;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import org.apache.commons.io.FilenameUtils;

@MultipartConfig(maxFileSize=16177215)
public class UpdatePicture extends HttpServlet{

	private static final long serialVersionUID = 1;
    DBConnection connection = new DBConnection();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer formId;
        String id = request.getParameter("formId");
        String qcId = request.getParameter("qcId");
        String type = request.getParameter("fileType");
        System.out.println("File type is " + type);
        InputStream inputStream = null;
        String imageName = null;
        Part filePart = request.getPart("photo");
        if (filePart != null) {
         //   imageName = filePart.getSubmittedFileName();
        	imageName="";
            System.out.println(imageName);
            System.out.println(filePart.getSize());
            System.out.println(filePart.getContentType());
            inputStream = filePart.getInputStream();
        }
        Connection conn = null;
        String message = null;
        String ext = FilenameUtils.getExtension((String)imageName);
        try {
            formId = Integer.valueOf(id);
        }
        catch (NumberFormatException e) {
            formId = null;
        }
        catch (Exception e) {
            formId = null;
        }
        try {
            try {
                conn = this.connection.getConnectionApp();
                String sql = null;
                if (inputStream != null) {
                    if (type.equals("p")) {
                        sql = "UPDATE `qcollect`.`data_form` SET `photograph` = ?,photo_ext=?  WHERE `formId` = ?";
                    } else if (type.equals("s")) {
                        sql = "UPDATE `qcollect`.`data_form` SET `signature` = ?,signature_ext=?  WHERE `formId` = ?";
                    }
                    PreparedStatement ps = conn.prepareStatement(sql);
                    ps.setBlob(1, inputStream);
                    ps.setString(2, ext);
                    if (formId == null) {
                        formId = this.getFormId(qcId);
                        ps.setInt(3, formId);
                    } else {
                        ps.setInt(3, formId);
                    }
                    int row = ps.executeUpdate();
                    if (row > 0) {
                        message = "File Update and saved Successfully";
                    }
                }
            }
            catch (SQLException ex) {
                message = "ERROR: " + ex.getMessage();
                ex.printStackTrace();
                if (conn != null) {
                    try {
                        conn.close();
                    }
                    catch (SQLException ex2) {
                        ex2.printStackTrace();
                    }
                }
                request.setAttribute("Message", (Object)message);
                this.getServletContext().getRequestDispatcher("/Message.jsp").forward((ServletRequest)request, (ServletResponse)response);
            }
        }
        finally {
            if (conn != null) {
                try {
                    conn.close();
                }
                catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            request.setAttribute("Message", (Object)message);
            this.getServletContext().getRequestDispatcher("/Message.jsp").forward((ServletRequest)request, (ServletResponse)response);
        }
    }

    public int getFormId(String qcId) {
        Integer instId;
        block31 : {
            instId = 0;
            Connection conn = null;
            Statement stmt = null;
            try {
                conn = this.connection.getConnectionApp();
                stmt = conn.createStatement();
                String sql = "SELECT * FROM qcollect.data_form where formTransId='" + qcId.trim() + "'";
                ResultSet rs = stmt.executeQuery(sql);
                if (rs != null && rs.next()) {
                    int id = rs.getInt("formId");
                    System.out.println("formId id is = " + id);
                    instId = id;
                } else {
                    System.out.println(" Record Not Available");
                }
                rs.close();
            }
            catch (SQLException se) {
                se.printStackTrace();
                try {
                    if (stmt != null) {
                        conn.close();
                    }
                    break block31;
                }
                catch (SQLException se2) {
                    try {
                        if (conn != null) {
                            conn.close();
                        }
                        break block31;
                    }
                    catch (SQLException see) {
                        see.printStackTrace();
                    }
                }
                break block31;
            }
            catch (Exception e) {
                try {
                    e.printStackTrace();
                    break block31;
                }
                catch (Throwable throwable) {
                    throw throwable;
                }
                finally {
                    try {
                        if (stmt != null) {
                            conn.close();
                        }
                    }
                    catch (SQLException se) {
                        try {
                            if (conn != null) {
                                conn.close();
                            }
                        }
                        catch (SQLException see) {
                            see.printStackTrace();
                        }
                    }
                }
            }
            try {
                if (stmt != null) {
                    conn.close();
                }
            }
            catch (SQLException se) {
                try {
                    if (conn != null) {
                        conn.close();
                    }
                }
                catch (SQLException see) {
                    see.printStackTrace();
                }
            }
        }
        return instId;
    }
}
