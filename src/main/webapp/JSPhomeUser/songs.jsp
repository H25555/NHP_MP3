<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<style>
.song-play-area > .audioplayer-time,
.song-play-area > .audioplayer-playpause,
.song-play-area > .audioplayer-time
.song-play-area > .audioplayer-volume{
    display: none;
}

.song-play-area{

    width: 100% !important;
}
#musicSingle{
    display: none;
    width: 100%;
}
.audioplayer-playpause.active {
    color: #867878;
}



</style>
<%@ include file="headerU.jsp" %>
<!-- ##### Breadcumb Area Start ##### -->
<section class="breadcumb-area bg-img bg-overlay" style="background-image: url(img/bg-img/breadcumb3.jpg);">
    <div class="bradcumbContent">
        <p>See what’s new</p>
        <h2>Latest Albums</h2>
    </div>
</section>
<!-- ##### Breadcumb Area End ##### -->

<!-- ##### Album Catagory Area Start ##### -->
<section class="album-catagory section-padding-100-0">
    <div class="container">
        <div class="row oneMusic-albums">
            <c:forEach items="${songs}" var="song">
                <div style="height: 300px" class="col-12 col-sm-4 col-md-3 col-lg-2 single-album-item t c p">
                    <div style="height: 280px" class="single-album">
                        <img style="height: 60%" src="${song.image}" alt="">
                        <div class="album-info">
                            <a href="javascript:void(0);" onclick="playSong(${song.id})">
                                <h5>${song.name}</h5>
                            </a>
                            <p>${song.singer.name}</p>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
    <ul>
        <div style="text-align: center">
            <c:forEach begin="1" end="${pageable.totalPage}" var="page">
        <span>
        <a href="/list_songs?page=${page}&search=${pageable.search}&sortBy=${pageable.sortBy}&nameField=${pageable.nameField}"><button>${page}</button></a>
        </span>
            </c:forEach>
        </div>

    </ul>
</section>


    <div class="container-fluid">
        <div class="row" >
            <!-- Single Song Area -->
            <div class="col-12">

                    <div class="song-play-area" id="musicSingle">

                    </div>

            </div>
        </div>
    </div>


<%--<div class="one-music-songs-area mb-70">--%>
<%--    <div class="container">--%>
<%--        <div class="row" >--%>
<%--            <!-- Single Song Area -->--%>
<%--            <div class="col-12">--%>
<%--                <div class="single-song-area mb-30 d-flex align-items-end">--%>
<%--                    <div class="song-play-area" id="musicSingle">--%>

<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</div>--%>
<%--<section id="audioContainer" class="single-song-area">--%>

<%--    <div class="container">--%>
<%--        <div class="row">--%>
<%--            <div class="col-12">--%>
<%--                <div class="container-audio">--%>
<%--                    <audio controls  loop autoplay id="audioPlayer1">--%>
<%--                    </audio>--%>
<%--                </div>--%>
<%--                <div class="player-controls">--%>
<%--                    <div class="player-progress">--%>
<%--                        <input type="range" id="progressSlider" min="0" max="100" step="0.1">--%>
<%--                    </div>--%>
<%--                    <div class="player-buttons">--%>
<%--                        <button id="volumeUpButton">&#x1f50a;</button>--%>
<%--                        <button id="prevButton">&lt;</button>--%>
<%--                        <button id="playPauseButton">&#9658;</button>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</section>--%>

<script>

    window.addEventListener('scroll', scrolled);
    function scrolled(event){
        var audioContainer = document.getElementById('musicSingle');
        var footer = document.getElementById("footer");
        var footerY = footer.scrollHeight ;
        var scrollY = window.scrollY;
        if(scrollY>=500){
            audioContainer.style.marginBottom = '120px';
        } else {
            audioContainer.style.marginBottom = '0px';

        }


    }

    // Lấy các phần tử cần sử dụng

    var progressBar = document.getElementById('progressBar');
    var playPauseButton = document.getElementById('playPauseButton');
    var prevButton = document.getElementById('prevButton');
    var nextButton = document.getElementById('nextButton');
    var randomButton = document.getElementById('randomButton');
    <% String products = (String) request.getAttribute("songsJSON"); %>
    let songs = <%= products %>;
    var songSelected;
    function playSong(id) {


        songSelected = songs.find(e => e.id === id);
        playAudio();
        showAudioPlayer();
    }
    function playAudio(){
        musicSingle.innerHTML = '';
        let str = `<div class="song-name" >
                            <p id="nameSong">\${songSelected.name}</p>
                        </div>
                        <div class="d-flex justify-content-between">
                            <button type="button" onclick="prev()" class="audioplayer-playpause">
                                <i class="fas fa-backward"></i>
                            </button>
                            <button type="button" onclick="next()" class="audioplayer-playpause">
                                <i class="fas fa-forward"></i>
                            </button>

                            <audio style="width: 80%;" id="audioPlayer1" preload="auto" controls onplaying="getView(\${songSelected.id})" onpause="getDuration()">
                                <source id="srcSong" src="\${songSelected.song}">
                            </audio>
                            <button type="button" onclick="toggleRandom()" class="audioplayer-playpause">
                                <i class="fas fa-random"></i>
                            </button>

                        </div>`;
        musicSingle.innerHTML = str;
        var audioPlayer = document.getElementById('audioPlayer1');
        audioPlayer.play();
    }

    function next() {
        if (isRandom) {
            const randomIndex = Math.floor(Math.random() * songs.length);
            songSelected = songs[randomIndex];
        } else {
            for (let i = 0; i < songs.length; i++) {
                if (songs[i].id === songSelected.id) {
                    songSelected = songs[(i + 1) % songs.length];
                    break;
                }
            }
        }
        playAudio();
    }

    function prev() {
        if (isRandom) {
            const randomIndex = Math.floor(Math.random() * songs.length);
            songSelected = songs[randomIndex];
        } else {
            for (let i = 0; i < songs.length; i++) {
                if (songs[i].id === songSelected.id) {
                    songSelected = songs[(i - 1 + songs.length) % songs.length];
                    break;
                }
            }
        }
        playAudio();
    }
    let isRandom = false;


    function toggleRandom() {
        isRandom = !isRandom;
        var button = document.querySelector('.audioplayer-playpause');
        button.classList.toggle('active');
    }


    function showAudioPlayer() {
        var audioContainer = document.getElementById('musicSingle');
        audioContainer.style.display = 'block';
        audioContainer.style.position = 'fixed';
        audioContainer.style.bottom = '0';
        audioContainer.style.left = '0';
        audioContainer.style.width = '100%';
        audioContainer.style.zIndex = '100';

        var footer = document.getElementById("footer");
        var footerY = footer.scrollHeight ;
        var scrollY = window.scrollY;
        if(scrollY>=500){
            audioContainer.style.marginBottom = '130px';
        }


    }
    var countSecond;
    var startDate;
    var pauseDate = 0;
    var timeOut;
    // ?action=view&+
    function getView(idsong){
        startDate = new Date();
        timeOut = setTimeout(() => {
            fetch('http://localhost:8080/api?action=view&id=' + idsong)
            pauseDate =0;
        }, (60 - pauseDate) * 1000)
    }
    function getDuration(){
        clearTimeout(timeOut);
        let diff = (new Date() - startDate);
        pauseDate = Math.floor((diff / 1000));
    }
</script>

<%@ include file="footerU.jsp" %>



