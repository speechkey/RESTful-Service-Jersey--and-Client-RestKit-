package net.gremoz.rest.resources;

import java.util.List;

import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import net.gremoz.rest.User;
import net.gremoz.rest.UserIndex;
/**
 *
 * @author Artem Grebenkin
 *
 */
@Path("/user")
public class UserResource {

    UserIndex index = new UserIndex();

    @GET
    @Produces({MediaType.APPLICATION_JSON})
    public List<User> findAll() {
        System.out.println("GET: All users from card index.");
        return index.getAll();
    }

    @GET
    @Path("{id}")
    @Produces({MediaType.APPLICATION_JSON})
    public List<User> findById(@PathParam("id") int id) {
        System.out.println("GET: User " + id + "by id.");
        return index.getById(id);
    }

    @POST
    @Consumes({MediaType.APPLICATION_JSON})
    @Produces({MediaType.APPLICATION_JSON})
    public List<User> create(User user) {
        System.out.println("POST: Create user " + user.getName() + " info.");
        return index.create(user);
    }

    @PUT
    @Path("{id}")
    @Consumes({MediaType.APPLICATION_JSON})
    @Produces({MediaType.APPLICATION_JSON})
    public List<User> update(User user) {
        System.out.println("PUT: Update user " + user.getName() + " info.");
        return index.update(user);
    }

    @DELETE
    @Path("{id}")
    @Produces({MediaType.APPLICATION_JSON})
    public void remove(@PathParam("id") int id) {
        System.out.println("DELETE: Delete user " + id + " info.");
        index.remove(id);
    }
}
