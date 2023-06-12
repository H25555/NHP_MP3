package model;

public class Like {
    private int id;
    private User user;
    private Song song;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Song getSong() {
        return song;
    }

    public void setSong(Song song) {
        this.song = song;
    }

    public Like(int id, User user, Song song) {
        this.id = id;
        this.user = user;
        this.song = song;
    }
}
