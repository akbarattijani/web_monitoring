package com.web.monitor;

import com.mashape.unirest.http.HttpResponse;
import com.mashape.unirest.http.Unirest;
import org.json.JSONArray;
import org.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by AKBAR on 13/01/2020.
 */

@WebServlet("/DashboardController")
public class DashboardController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String type = request.getParameter("type");
        String nip = request.getParameter("nip");
        String name = request.getParameter("name");

        if (type.equals("1")) {
            request.setAttribute("nip", nip);
            request.setAttribute("name", name);
            request.getSession().setAttribute("auth", nip);
            request.getRequestDispatcher("/pages/forms/dashboard.jsp").forward(request, response);
        } else if (type.equals("2")) {
            requestTwo(request, response);
        } else if (type.equals("3")) {
            try {
                String assign = request.getParameter("assign");
                HttpResponse<String> result = Unirest
                        .get("https://monitoring-api.herokuapp.com/api/v1/attendance/getAll/" + assign)
                        .header("Authorization", "ApiAuth api_key=DMA128256512AI")
                        .asString();

                System.out.println("Call Back Response : " + result.getStatus() + "/" + result.getStatusText() + "\t" + result.getBody());
                if (result.getStatus() != 200) {
                    throw new Exception(result.getStatus() + "/" + result.getStatusText());
                } else {
                    JSONObject object = new JSONObject(result.getBody());
                    JSONArray res = new JSONArray(object.getString("result"));
                    int code = object.getInt("code");
                    if (code == 200) {
                        request.setAttribute("nip", nip);
                        request.setAttribute("name", name);
                        request.setAttribute("data", res.toString());
                        request.getSession().setAttribute("auth", nip);
                        request.getRequestDispatcher("/pages/forms/listabsen.jsp").forward(request, response);
                    } else {
                        requestTwo(request, response);
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else if (type.equals("4")) {
            try {
                String assign = request.getParameter("assign");
                HttpResponse<String> result = Unirest
                        .get("https://monitoring-api.herokuapp.com/api/v1/attendance/getDetail/" + assign)
                        .header("Authorization", "ApiAuth api_key=DMA128256512AI")
                        .asString();

                System.out.println("Call Back Response : " + result.getStatus() + "/" + result.getStatusText() + "\t" + result.getBody());
                if (result.getStatus() != 200) {
                    throw new Exception(result.getStatus() + "/" + result.getStatusText());
                } else {
                    JSONObject object = new JSONObject(result.getBody());
                    JSONArray res = new JSONArray(object.getString("result"));
                    int code = object.getInt("code");
                    if (code == 200) {
                        request.setAttribute("nip", nip);
                        request.setAttribute("name", name);
                        request.setAttribute("data", res.toString());
                        request.getSession().setAttribute("auth", nip);
                        request.getRequestDispatcher("/pages/forms/detailsales.jsp").forward(request, response);
                    } else {
                        requestTwo(request, response);
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    private void requestTwo(HttpServletRequest request, HttpServletResponse response) {
        String nip = request.getParameter("nip");
        String name = request.getParameter("name");

        try {
            HttpResponse<String> result = Unirest
                    .get("https://monitoring-api.herokuapp.com/api/v1/user/getAll")
                    .header("Authorization", "ApiAuth api_key=DMA128256512AI")
                    .asString();

            System.out.println("Call Back Response : " + result.getStatus() + "/" + result.getStatusText() + "\t" + result.getBody());
            if (result.getStatus() != 200) {
                throw new Exception(result.getStatus() + "/" + result.getStatusText());
            } else {
                JSONObject object = new JSONObject(result.getBody());
                JSONArray res = new JSONArray(object.getString("result"));
                int code = object.getInt("code");
                if (code == 200) {
                    request.setAttribute("nip", nip);
                    request.setAttribute("name", name);
                    request.setAttribute("data", res.toString());
                    request.getSession().setAttribute("auth", nip);
                    request.getRequestDispatcher("/pages/forms/listsales.jsp").forward(request, response);
                } else {
                    request.setAttribute("nip", nip);
                    request.setAttribute("name", name);
                    request.getSession().setAttribute("auth", nip);
                    request.getRequestDispatcher("/pages/forms/dashboard.jsp").forward(request, response);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
