package model;

public class ISP {
    private int id;
    private Song song;
    private User user;

    public ISP(int id, Song song, User user) {
        this.id = id;
        this.song = song;
        this.user = user;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Song getSong() {
        return song;
    }

    public void setSong(Song song) {
        this.song = song;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
}
