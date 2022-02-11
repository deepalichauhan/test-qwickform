package com.sabpaisa.qforms.WebXmlFile;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import org.apache.commons.io.FilenameUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sabpaisa.qforms.util.DBConnection;

@Controller
@RequestMapping
@MultipartConfig(maxFileSize = 16177215)
public class UpdatePicture extends HttpServlet {

	private static final long serialVersionUID = 1L;
	DBConnection connection = new DBConnection();

	private static Logger log = LogManager.getLogger(UpdatePicture.class.getName());
	
	
	protected void doPost(Model model,HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		log.info("doPost PhotoUpload action");
		String id = request.getParameter("formId");
		String qcId = request.getParameter("qcId");
		String type = request.getParameter("fileType");
		log.info("file type is {"+type+"}, id {"+id+"}, qcId {"+qcId+"}");
		
		System.out.println("File type is "+type);
		InputStream inputStream = null; // input stream of the upload file
		String imageName = null;
		Part filePart = request.getPart("photo");
		if (filePart != null) {
			// prints out some information for debugging
			//imageName = filePart.getSubmittedFileName();
			imageName = "";
			log.info("imageName >>>> "+imageName);
			System.out.println(imageName);
			log.info("filePart.getSize() >>>> "+filePart.getSize());
			System.out.println(filePart.getSize());
			log.info("filePart.getContentType() >>>> "+filePart.getContentType());
			System.out.println(filePart.getContentType());

			inputStream = filePart.getInputStream();
		}
		Connection conn = null; // connection to the database
		String message = null; // message will be sent back to client
		String ext = FilenameUtils.getExtension(imageName);
		log.info("imageName ext >>>> "+ext);
		Integer formId;
		try {
			formId = Integer.valueOf(id);
		} catch (NumberFormatException e) {
			formId = null;
		} catch (Exception e) {
			formId = null;
		}

		try {
			// connects to the database

			conn = connection.getConnectionApp();
			String sql=null;
			if (inputStream != null) {

				if(type.equals("p")){
					sql = "UPDATE `QForms`.`data_form` SET `photograph` = ?,photo_ext=?  WHERE `formId` = ?";
				}else if(type.equals("s")){
					sql = "UPDATE `QForms`.`data_form` SET `signature` = ?,signature_ext=?  WHERE `formId` = ?";
				}
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setBlob(1, inputStream);
				ps.setString(2, ext);
				if (formId == null) {
					formId = getFormId(qcId);
					ps.setInt(3, formId);
				} else {
					ps.setInt(3, formId);
				}
				int row = ps.executeUpdate();
				if (row > 0) {
					message = "File Update and saved Successfully";
				}

			}

		} catch (SQLException ex) {
			message = "ERROR: " + ex.getMessage();
			ex.printStackTrace();
		} finally {
			if (conn != null) {
				// closes the database connection
				try {
					conn.close();
				} catch (SQLException ex) {
					ex.printStackTrace();
				}
			}
			// sets the message in request scope
			request.setAttribute("Message", message);

			// forwards to the message page
			getServletContext().getRequestDispatcher("/Message.jsp").forward(request, response);
		}
	}

	public int getFormId(String qcId) {
		Integer instId = 0;
		Connection conn = null;
		Statement stmt = null;
		try {

			conn = connection.getConnectionApp();
			stmt = conn.createStatement();

			String sql = "SELECT * FROM QForms.data_form where formTransId='" + qcId.trim() + "'";
			ResultSet rs = stmt.executeQuery(sql);

			if (rs != null && rs.next()) {
				int id = rs.getInt("formId");
				System.out.println("formId id is = " + id);
				instId = id;

			} else {

				System.out.println(" Record Not Available");

			}

			rs.close();
		} catch (SQLException se) {
			se.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (stmt != null)
					conn.close();
			} catch (SQLException se) {
				try {
					if (conn != null)
						conn.close();
				} catch (SQLException see) {
					see.printStackTrace();
				}

			}
		}
		return instId;
	}
}
