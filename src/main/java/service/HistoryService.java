package service;

import dao.HistoryDAO;
import model.History;

public class HistoryService {
    HistoryDAO historyDAO = new HistoryDAO();
    public int countSongHistory(int idSong){
        return historyDAO.countSongHistory(idSong);
    }
    public void createViewHistory(History history){
        historyDAO.createViewHistory(history);
    }
}
