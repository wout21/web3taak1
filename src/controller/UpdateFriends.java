package controller;

import com.google.gson.JsonObject;
import domain.Person;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class UpdateFriends extends RequestHandler {
    @Override
    public void handleRequest(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        Person currUser = (Person) request.getSession().getAttribute("user");

        response.setContentType("text/json");
        response.getWriter().write(this.toJSON(currUser.getFriends()));

    }

    private String toJSON(List<Person> friends) {
        JsonObject friendJSON = new JsonObject();
        for (Person p : friends) {
            JsonObject friend = new JsonObject();
            friend.addProperty("name", p.getLastName() + " " + p.getFirstName());
            friend.addProperty("status", p.getStatus());
            friendJSON.add(p.getUserId(), friend);
        }
        return friendJSON.toString();
    }
}
