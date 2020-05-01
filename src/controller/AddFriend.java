package controller;

import domain.Person;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class AddFriend extends RequestHandler {
    @Override
    public void handleRequest(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        Person currUser = (Person) request.getSession().getAttribute("user");
        if (currUser != null) {
            Person p = getPersonService().getPerson(request.getParameter("name"));
            if(p != null) {
                p.addFriend(currUser);
                currUser.addFriend(p);
            }
        }
    }
}
