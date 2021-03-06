<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="/includes/taglib.jsp" %>

<!DOCTYPE html>
<html>
<head>

    <%@ include file="/includes/header.jsp" %>
    <link href="<%=contextPath%>/css/user.css" rel="stylesheet">
    <link href="<%=contextPath%>/css/pagination.css" rel="stylesheet">

</head>
<body>


<%-- 头部导航栏 --%>
<%@ include file="/includes/nav-top.jsp" %>
<div class="main">
    <div class="container">

        <div class="page-header m-page-header">
            <h3 class="page-header-title">用户</h3>
        </div>

        <div class="page-query">

            <table style="width: 100%;">
                <tbody>
                <tr>
                    <td>
                        <%--<input id="userfilter" name="userfilter" class="form-control m-form-control" type="text"--%>
                               <%--value="" style="m    argin-left: 10px;">--%>

                        <input id="total" type="hidden" name="total" value="${pageInfo.total}">
                        <form class="form-inline" action="/users">
                            <input id="pageNum" type="hidden" name="pageNum" value="${pageInfo.pageNum}">
                            <input id="pageSize" type="hidden" name="pageSize" value="${pageInfo.pageSize}">
                            <div class="input-group">
                                <input id="search" name="search" type="text" value="${search}" class="form-control" placeholder="搜索用户...">
                              <span class="input-group-btn">
                                <button class="btn btn-default" type="submit">搜索</button>
                              </span>
                            </div>
                        </form>

                    </td>
                    <%--<td style="text-align: right;">--%>
                    <%--<div id="tabs-interval" class="subtabs">--%>
                    <%--<a href="/users?tab=Reputation&amp;filter=all" data-nav-xhref="" title="2008-07-31 to today"--%>
                    <%--data-value="all" data-shortcut="">--%>
                    <%--all</a>--%>
                    <%--<a href="/users?tab=Reputation&amp;filter=year" data-nav-xhref=""--%>
                    <%--title="2017-01-01 to today" data-value="year" data-shortcut="">--%>
                    <%--year</a>--%>
                    <%--<a href="/users?tab=Reputation&amp;filter=quarter" data-nav-xhref=""--%>
                    <%--title="2017-04-01 to today" data-value="quarter" data-shortcut="">--%>
                    <%--quarter</a>--%>
                    <%--<a href="/users?tab=Reputation&amp;filter=month" data-nav-xhref=""--%>
                    <%--title="2017-05-01 to today" data-value="month" data-shortcut="">--%>
                    <%--month</a>--%>
                    <%--<a class="youarehere" href="/users?tab=Reputation&amp;filter=week" data-nav-xhref=""--%>
                    <%--title="2017-05-21 to today" data-value="week" data-shortcut="">--%>
                    <%--week</a>--%>
                    <%--</div>--%>
                    <%--</td>--%>
                </tr>
                </tbody>
            </table>
        </div>

        <div id="user-browser" class="user-browser">
            <table>
                <tbody>
                <tr>
                    <c:forEach var="user" items="${pageInfo.list}" varStatus="status">
                    <c:if test="${status.index != 0 && status.index % 4 == 0}">
                </tr>
                <tr>
                    </c:if>
                    <td>
                        <div class="user-info user-hover">
                            <div class="user-gravatar">
                                <a href="/users/${user.id}/detail">
                                    <div class="gravatar-wrapper-48"><img src="https://avatars.githubusercontent.com/u/4217102?v=3" alt="" width="48"
                                                                          height="48"></div>
                                </a>
                            </div>
                            <div class="user-details">
                                <a href="/users/${user.id}/detail">${user.name}</a>
                                <span class="user-location">${user.address}</span>
                                <div class="-flair">
                                    <span class="reputation-score"
                                          title="reputation this week: 1,180 total reputation: 122,426"
                                          dir="ltr">1,180</span>
                                </div>
                            </div>
                            <div class="user-tags">
                                <a href="#">java</a>,
                                <a href="#">android</a>,
                                <a href="#">html</a>
                            </div>
                        </div>
                    </td>
                    </c:forEach>
                </tr>
                </tbody>
            </table>
            <%--分页--%>
            <div id="pagination-container" style="margin-top: 30px; margin-bottom: 30px;" class="pull-right">
            </div>
            <%--<ul id="pagination-demo" class="pagination-sm"></ul>--%>

        </div>

    </div>
    <%@ include file="/includes/footer.jsp" %>

</div>

<%@ include file="/includes/jquery-bootstrap-js.jsp" %>
<%@ include file="/includes/top-nav-js.jsp" %>
<%@ include file="/includes/top-progress.jsp" %>
<script src="<%=contextPath%>/js/pagination.js"></script>
<%--<script src="<%=contextPath%>/js/jquery.twbsPagination.js.js"></script>--%>

<script type="text/javascript">


//    $(document).ready(function() {
//        $('#pagination-demo').twbsPagination({
//            totalPages: 35,
//            visiblePages: 7,
//            onPageClick: function (event, page) {
//                $('#page-content').text('Page ' + page);
//            }
//        });
//    });



    $(function () {
        createPagination();
    });

    var container = $('#pagination-container');
    function createPagination() {
        var sources = function () {
            var result = [];

            var total = Number($('#total').val()) + 1;
            for (var i = 1; i < total; i++) {
                result.push(i);
            }

            return result;
        }();

        var options = {
            dataSource: sources,
            pageNumber: $('#pageNum').val(),

//            showGoButton: true,
//            showGoInput: true,
            showPrevious: true,
            showNext: true,
            pageSize: $('#pageSize').val(),
            callback: function (response, pagination) {
            }
        };
        container.pagination(options);

        //$.pagination(container, options);
        // 点击上一页
        container.addHook('afterPreviousOnClick', function () {
            getPageData();
        });
        // 点击下一页
        container.addHook('afterNextOnClick', function () {
            getPageData();
        });
        // 点击某一页
        container.addHook('afterPageOnClick', function () {
            getPageData();
        });

        return container;
    }

    function getPageData() {
        // 获取当前选中页码
        var pageNum = container.pagination('getSelectedPageNum');
        var pageSize = $('#pageSize').val();
        var search = $('#search').val();
        location.href = "users?pageNum=" + pageNum + "&pageSize=" + pageSize + "&search=" + search;
    }
</script>
</body>
</html>