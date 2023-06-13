<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Songs</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
  <style>
    .song-item {
      cursor: pointer;
      display: flex;
      align-items: center;
      justify-content: space-between;
      padding: 10px;
      border-bottom: 1px solid #ccc;
    }

    .song-info {
      flex: 1;
    }

    .song-name {
      margin-bottom: 5px;
    }

    .song-controls {
      display: none;
    }

    .song-item.active .song-controls {
      display: flex;
    }

    .play-icon {
      font-size: 20px;
      color: #888;
      cursor: pointer;
      margin-right: 5px;
    }

    .play-icon:hover {
      color: #000;
    }

    .play-icon.active {
      color: #ff0000;
    }

    .play-icon.rotate {
      animation: rotate 2s infinite linear;
    }

    @keyframes rotate {
      100% {
        transform: rotate(360deg);
      }
    }
  </style>
</head>
<body>
<h1>List of Songs</h1>
<div>
  <c:forEach items="${songs}" var="song" varStatus="status">
    <div class="song-item" id="song${status.index}">
      <div class="song-info">
        <div class="song-name">${song.name}</div>
        <audio controls class="song-play" id="audio${status.index}">
          <source src="${pageContext.request.contextPath}${song.song}" type="audio/mp3">
        </audio>
      </div>
      <div class="song-controls">
        <button class="play-icon sequential" id="auto-next-sequential${status.index}" title="Auto Next Song (Sequential)"> <i class="fas fa-sync-alt"></i></button>
        <button class="play-icon random" id="auto-next-random${status.index}" title="Auto Next Song (Random)"><i class="fas fa-random"></i></button>
      </div>
    </div>
  </c:forEach>
</div>

<script>
  let currentPlayMode = null;
  let currentSongIndex = 0;
  const songItems = document.querySelectorAll('.song-item');
  const playIcons = document.querySelectorAll('.play-icon');
  let currentAudio = null;

  function playNextSong() {
    currentSongIndex++;
    if (currentSongIndex >= songItems.length) {
      currentSongIndex = 0;
    }

    const songItem = songItems[currentSongIndex];
    const audio = songItem.querySelector('.song-play');
    stopAllSongs(); // Tắt bài hát hiện tại
    audio.play();
    currentAudio = audio;

    songItems.forEach(item => item.classList.remove('active'));
    songItem.classList.add('active');
  }

  function playRandomSong() {
    const randomIndex = Math.floor(Math.random() * songItems.length);
    const songItem = songItems[randomIndex];
    const audio = songItem.querySelector('.song-play');
    stopAllSongs(); // Tắt bài hát hiện tại
    audio.play();
    currentAudio = audio;

    songItems.forEach(item => item.classList.remove('active'));
    songItem.classList.add('active');
  }

  function stopAllSongs() {
    songItems.forEach(songItem => {
      const audio = songItem.querySelector('.song-play');
      audio.pause();
      audio.currentTime = 0;
      songItem.classList.remove('active');
    });
  }

  function togglePlayMode(playMode, index) {
    if (currentPlayMode === playMode) {
      currentPlayMode = null;
      playIcons.forEach(icon => icon.classList.remove('active'));
    } else {
      currentPlayMode = playMode;
      playIcons.forEach(icon => icon.classList.remove('active'));
      document.getElementById(playMode + index).classList.add('active');
    }
  }

  songItems.forEach((songItem, index) => {
    const audio = songItem.querySelector('.song-play');
    audio.addEventListener('ended', () => {
      if (currentPlayMode === 'auto-next-sequential') {
        playNextSong();
      } else if (currentPlayMode === 'auto-next-random') {
        playRandomSong();
      }
    });

    songItem.addEventListener('click', () => {
      if (songItem.classList.contains('active')) {
        if (audio.paused) {
          audio.play();
        } else {
          audio.pause();
        }
      } else {
        stopAllSongs();
        audio.play();
        currentAudio = audio;
        currentSongIndex = index;
        songItem.classList.add('active');
      }
    });
  });

  playIcons.forEach(icon => {
    icon.addEventListener('click', () => {
      const playMode = icon.classList.contains('sequential') ? 'auto-next-sequential' : 'auto-next-random';
      const index = icon.id.replace(/[^\d.]/g, '');
      togglePlayMode(playMode, index);
    });
  });

  currentAudio = document.querySelector('.song-play');
  songItems[0].classList.add('active');
</script>
</body>
</html>