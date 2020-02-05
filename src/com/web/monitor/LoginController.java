package com.web.monitor;

import com.mashape.unirest.http.HttpResponse;
import com.mashape.unirest.http.Unirest;
import org.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


@WebServlet("/LoginController")
public class LoginController extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String nip=request.getParameter("nip");
		String password=request.getParameter("password");

		try {
			HttpResponse<String> result = Unirest
					.get("https://monitoring-api.herokuapp.com/api/v1/user/login/" + nip + "/" + password + "/1")
					.header("Authorization", "ApiAuth api_key=DMA128256512AI")
					.asString();

			System.out.println("Call Back Response : " + result.getStatus() + "/" + result.getStatusText() + "\t" + result.getBody());
			if (result.getStatus() != 200) {
				throw new Exception(result.getStatus() + "/" + result.getStatusText());
			} else {
				try {
					JSONObject object = new JSONObject(result.getBody());
					JSONObject res = new JSONObject(object.getString("result"));
					int code = object.getInt("code");
					if (code == 200) {
						request.setAttribute("nip", nip);
						request.setAttribute("name", res.getString("name"));
						request.setAttribute("data", result.getBody());
						request.getSession().setAttribute("auth", nip);
						request.getRequestDispatcher("/pages/forms/dashboard.jsp").forward(request, response);
					} else {
						request.getSession().setAttribute("auth", "nothing");
						request.getRequestDispatcher("/").forward(request, response);
					}
				} catch (Exception e) {
					e.printStackTrace();
					request.getSession().setAttribute("auth", "nothing");
					request.getRequestDispatcher("/").forward(request, response);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
