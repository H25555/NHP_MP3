

<%@ include file="header.jsp" %>
<div class="container">
  <div>
  <a href="songs?action=create">
    <button type="button" class="btn btn-success mr-1"><i class="fas fa-plus"></i> Create Song</button>
  </a>

  </div>
  <c:if test="${requestScope['songs'].size() != 0}">
    <table class="table container border" style="border: none !important; color: white">
      <tbody class="bg-light" style="border: none !important; color: white">
      <tr style="text-align: center" class="text-center ">
        <th style="text-align: center" scope="col">
          <c:if test="${pageable.sortBy== 'desc'}">
            <a
                    href="/songs?page=${pageable.page}&search=${pageable.search}&sortBy=asc&nameField=song.id">
              ID
            </a>
          </c:if>
          <c:if test="${pageable.sortBy== 'asc'}">
            <a
                    href="/songs?page=${pageable.page}&search=${pageable.search}&sortBy=desc&nameField=song.id">
              ID
            </a>
          </c:if>
        </th>
        <th style="text-align: center" scope="col">

          <c:if test="${pageable.sortBy== 'desc'}">
            <a
                    href="/songs?page=${pageable.page}&search=${pageable.search}&sortBy=asc&nameField=song.name">
              name
            </a>
          </c:if>
          <c:if test="${pageable.sortBy== 'asc'}">
            <a
                    href="/songs?page=${pageable.page}&search=${pageable.search}&sortBy=desc&nameField=song.name">
              name
            </a>
          </c:if>
        </th>
        <th style="text-align: center" scope="col">
          <c:if test="${pageable.sortBy== 'desc'}">
            <a
                    href="/songs?page=${pageable.page}&search=${pageable.search}&sortBy=asc&nameField=name_author">
              Author
            </a>
          </c:if>
          <c:if test="${pageable.sortBy== 'asc'}">
            <a
                    href="/songs?page=${pageable.page}&search=${pageable.search}&sortBy=desc&nameField=name_author">
              Author
            </a>
          </c:if>
        </th>
        <th style="text-align: center" scope="col">
          <c:if test="${pageable.sortBy== 'desc'}">
            <a
                    href="/songs?page=${pageable.page}&search=${pageable.search}&sortBy=asc&nameField=type">
              Category
            </a>
          </c:if>
          <c:if test="${pageable.sortBy== 'asc'}">
            <a
                    href="/songs?page=${pageable.page}&search=${pageable.search}&sortBy=desc&nameField=type">
              Category
            </a>
          </c:if>
        </th>
        <th style="text-align: center" scope="col">
          <c:if test="${pageable.sortBy== 'desc'}">
            <a
                    href="/songs?page=${pageable.page}&search=${pageable.search}&sortBy=asc&nameField=name_singer">
              Singer
            </a>
          </c:if>
          <c:if test="${pageable.sortBy== 'asc'}">
            <a
                    href="/songs?page=${pageable.page}&search=${pageable.search}&sortBy=desc&nameField=name_singer">
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
            <audio style="height: 30px" controls class="song-play" id="audio${status.index}">
              <source src="${song.song}" type="audio/mp3">
            </audio>
          </td>
          <td style="align-content: center; align-items: center" >
              <%--                                            ${song.song}--%>
            <img style="height: 40px;width: 40px;border-radius: 50%" class="image" src="${song.image}">
          </td>

          <td style="align-content: center; align-items: center"><a href="songs?action=edit&id=${song.id}"> <button type="button" class="btn btn-primary mr-1"><i class="fas fa-edit"></i></button></a> </td>
          <td style="align-content: center; align-items: center"><a href="songs?action=delete&id=${song.id}" onclick="return confirm('Do you want to remove ${song.name}?')"> <button type="button" class="btn btn-danger"><i class="fas fa-trash"></i></button></a> </td>
        </tr>
      </c:forEach>
      </tbody>
    </table>
    <ul>
      <div style="text-align: center">
        <c:forEach begin="1" end="${pageable.totalPage}" var="page">
        <span>
        <a href="/songs?page=${page}&search=${pageable.search}&sortBy=${pageable.sortBy}&nameField=${pageable.nameField}"><button>${page}</button></a>
        </span>
        </c:forEach>
      </div>

    </ul>
  </c:if>

</div>
<%@ include file="footer.jsp" %>

