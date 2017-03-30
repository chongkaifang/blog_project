<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- 文章发表时间，分类 --%>
<div class="sub-article-meta">
	<span>发表于&nbsp;</span> <span class="sub-article-post-time"> <fmt:formatDate
			value="${article.createTime}" pattern="yyyy-MM-dd HH:mm:ss" />
	</span> &nbsp;&nbsp; <span>分类于&nbsp;</span> <span
		class="sub-article-category-item"> <c:choose>
			<c:when test="${article.category == 1}">
				<a href="<%=contextPath%>/archive/java">Java</a>
			</c:when>
			<c:when test="${article.category == 2}">
				<a href="<%=contextPath%>/archive/android">Android</a>
			</c:when>
			<c:when test="${article.category == 3}">
				<a href="<%=contextPath%>/archive/db">DB</a>
			</c:when>
		</c:choose> &nbsp;&nbsp; <span><i class="glyphicon glyphicon-eye-open"></i>&nbsp;${article.beViewdNum}</span>
	</span>
	<%-- 用户登录后，才会显示编辑超链接 --%>
	<c:if test="${sessionScope.userid != null}">
		<span class="pull-right"><a
			href="<%=contextPath%>/article/${article.id}/delete">删除</a></span>
		<span class="pull-right m-pull-right"><a href="#"
			data-toggle="modal" data-target="#modal-edit" data-id="${article.id}">编辑</a></span>
	</c:if>
</div>