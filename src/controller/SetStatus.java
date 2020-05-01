package controller;

import com.google.gson.JsonObject;
import domain.Person;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class SetStatus extends RequestHandler {

    @Override
    public void handleRequest(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Person currUser = (Person) request.getSession().getAttribute("user");
        currUser.setStatus(request.getParameter("status"));
        getPersonService().updatePersons(currUser);

        response.setContentType("text/json");
        response.getWriter().write(this.toJSON(request.getParameter("status")));
    }

    private String toJSON(String status){
        JsonObject JSONobj = new JsonObject();
        JSONobj.addProperty("status", status);
        return JSONobj.toString();
    }
}
