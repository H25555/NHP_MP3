<%@ include file="../header.jsp" %>
<div class="container">
    <div class="container">
        <form method="post" action="/songs">
            <div class="form-row">
                <div class="form-group col-md-4">
                    <label for="author">Author</label>
                    <select class="form-control" id="author" name="author">
                        <option value="">All Authors</option>
                        <c:forEach items="${filterAuthor}" var="author">
                            <option value="${author.id}">${author.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group col-md-4">
                    <label for="singer">Singer</label>
                    <select class="form-control" id="singer" name="singer">
                        <option value="">All Singers</option>
                        <c:forEach items="${filterSinger}" var="singer">
                            <option value="${singer.id}">${singer.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group col-md-4">
                    <label for="category">Category</label>
                    <select class="form-control" id="category" name="category">
                        <option value="">All Categories</option>
                        <c:forEach items="${filterCategory}" var="category">
                            <option value="${category.id}">${category.name}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div>
                <button type="submit" class="btn btn-primary">Filter</button>
            </div>
        </form>
    </div>
    <c:if test="${requestScope['songs'].size() != 0}">
        <table class="table container border" style="border: none !important; color: white">
            <tbody class="bg-light" style="border: none !important; color: white">
            <tr style="text-align: center" class="text-center ">
                <th style="text-align: center" scope="col">
                    <c:if test="${pageable.sortBy== 'desc'}">
                        <a
                                href="admin/songs?page=${pageable.page}&search=${pageable.search}&sortBy=asc&nameField=song.id">
                            ID
                        </a>
                    </c:if>
                    <c:if test="${pageable.sortBy== 'asc'}">
                        <a
                                href="admin/songs?page=${pageable.page}&search=${pageable.search}&sortBy=desc&nameField=song.id">
                            ID
                        </a>
                    </c:if>
                </th>
                <th style="text-align: center" scope="col">

                    <c:if test="${pageable.sortBy== 'desc'}">
                        <a
                                href="admin/songs?page=${pageable.page}&search=${pageable.search}&sortBy=asc&nameField=song.name">
                            name
                        </a>
                    </c:if>
                    <c:if test="${pageable.sortBy== 'asc'}">
                        <a
                                href="admin/songs?page=${pageable.page}&search=${pageable.search}&sortBy=desc&nameField=song.name">
                            name
                        </a>
                    </c:if>
                </th>
                <th style="text-align: center" scope="col">
                    <c:if test="${pageable.sortBy== 'desc'}">
                        <a
                                href="admin/songs?page=${pageable.page}&search=${pageable.search}&sortBy=asc&nameField=name_author">
                            Author
                        </a>
                    </c:if>
                    <c:if test="${pageable.sortBy== 'asc'}">
                        <a
                                href="admin/songs?page=${pageable.page}&search=${pageable.search}&sortBy=desc&nameField=name_author">
                            Author
                        </a>
                    </c:if>
                </th>
                <th style="text-align: center" scope="col">
                    <c:if test="${pageable.sortBy== 'desc'}">
                        <a
                                href="admin/songs?page=${pageable.page}&search=${pageable.search}&sortBy=asc&nameField=type">
                            Category
                        </a>
                    </c:if>
                    <c:if test="${pageable.sortBy== 'asc'}">
                        <a
                                href="admin/songs?page=${pageable.page}&search=${pageable.search}&sortBy=desc&nameField=type">
                            Category
                        </a>
                    </c:if>
                </th>
                <th style="text-align: center" scope="col">
                    <c:if test="${pageable.sortBy== 'desc'}">
                        <a
                                href="admin/songs?page=${pageable.page}&search=${pageable.search}&sortBy=asc&nameField=name_singer">
                            Singer
                        </a>
                    </c:if>
                    <c:if test="${pageable.sortBy== 'asc'}">
                        <a
                                href="admin/songs?page=${pageable.page}&search=${pageable.search}&sortBy=desc&nameField=name_singer">
                            Singer
                        </a>
                    </c:if>
                </th>
                <th style="text-align: center" scope="col">Song</th>
                <th style="text-align: center" scope="col">Image</th>
            </tr>
            <c:forEach items="${songs}" var="song">
                <tr style="align-content: center">
                    <td style="align-content: center; align-items: center">${song.id}</td>
                    <td style="align-content: center; align-items: center">${song.name}</td>
                    <td style="align-content: center; align-items: center">${song.author.name}</td>
                    <td style="align-content: center; align-items: center">${song.category.name}</td>
                    <td style="align-content: center; align-items: center">${song.singer.name}</td>
                    <td style="align-content: center; align-items: center">
                            <%--                    ${song.image}--%>
                        <audio style="height: 30px" controls class="song-play" onplaying="onPlay(${song.id})" id="audio${status.index}">
                            <source src="<c:url value='/${song.song}'></c:url>" type="audio/mp3">
                        </audio>
                    </td>
                    <td style="align-content: center; align-items: center">
                            <%--                                            ${song.song}--%>
                        <img style="height: 40px;width: 40px;border-radius: 50%" class="image" src="${song.image}">
                    </td>

                    <td style="align-content: center; align-items: center"><a href="songs?action=edit&id=${song.id}">
                        <button type="button" class="btn btn-primary mr-1"><i class="fas fa-edit"></i></button>
                    </a></td>
                    <td style="align-content: center; align-items: center"><a href="songs?action=delete&id=${song.id}"
                                                                              onclick="return confirm('Do you want to remove ${song.name}?')">
                        <button type="button" class="btn btn-danger"><i class="fas fa-trash"></i></button>
                    </a></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <ul>
            <div style="text-align: center">
                <c:forEach begin="1" end="${pageable.totalPage}" var="page">
        <span>
        <a href="/admin/songs?page=${page}&search=${pageable.search}&sortBy=${pageable.sortBy}&nameField=${pageable.nameField}"><button>${page}</button></a>
        </span>
                </c:forEach>
            </div>

        </ul>
    </c:if>

</div>

<script>
    function onPlay(id){
        const timeOut = setTimeout(() => {
            fetch('http://localhost:8080/api?id='+id);
        }, 60*1000)
    }
</script>
<%@ include file="../footer.jsp" %>

