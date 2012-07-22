/**
 * 
 */
package net.gremoz.rest;

import java.io.IOException;
import java.net.URI;
import java.util.HashMap;
import java.util.Map;

import javax.ws.rs.core.UriBuilder;

import com.sun.grizzly.http.SelectorThread;
import com.sun.jersey.api.container.grizzly.GrizzlyWebContainerFactory;
/**
 * @author Artem Grebenkin
 *
 */
public class iServer {

    private static int getPort(int defaultPort) {
        String port = System.getenv("JERSEY_HTTP_PORT");
        if (null != port) {
            try {
                return Integer.parseInt(port);
            } catch (NumberFormatException e) {
            }
        }
        return defaultPort;        
    } 
    
    private static URI getBaseURI() {
        return UriBuilder.fromUri("http://localhost/").port(getPort(9988)).build();
    }

    public static final URI BASE_URI = getBaseURI();

    protected static SelectorThread startServer() throws IOException {
        final Map<String, String> initParams = new HashMap<String, String>();

        initParams.put("com.sun.jersey.config.property.packages", 
                "net.gremoz.rest.resources");

        System.out.println("Starting grizzly...");
        SelectorThread threadSelector = GrizzlyWebContainerFactory.create(BASE_URI, initParams);     
        return threadSelector;
    }
    
    public static void main(String[] args) throws IOException {
        SelectorThread threadSelector = startServer();
        System.out.println(String.format("Jersey app started with WADL available at "
                + "%sapplication.wadl\nTry out %shelloworld\nHit enter to stop it...",
                BASE_URI, BASE_URI));
        System.in.read();
        threadSelector.stopEndpoint();
    }  
}
