package net.gremoz.rest;

import javax.xml.bind.annotation.XmlRootElement;

/**
 * @author Artem Grebenkin
 */
@XmlRootElement
public class User {

    private int id;
    private String name;
    private String about;
    private String photo;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAbout() {
        return about;
    }

    public void setAbout(String about) {
        this.about = about;
    }

    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }
}
