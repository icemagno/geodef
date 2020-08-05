<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

	          <!-- User Account Menu -->
	          <li class="dropdown user user-menu">
	            <!-- Menu Toggle Button -->
	            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
	              <!-- The user image in the navbar-->
	              <img src="${user.profileImage}" class="user-image" alt="User Image">
	              <!-- hidden-xs hides the username on small devices so only the image appears. -->
	              <span class="hidden-xs">${user.fullName}</span>
	            </a>
	            <ul class="dropdown-menu">
	              <!-- The user image in the menu -->
	              <li class="user-header">
	                <img src="${user.profileImage}" class="img-circle" alt="User Image">
	
	                <p>
	                  
					<small>${user.fullName}</small>
		            <small>${user.username}</small>
						                  
	                  
	                </p>
	              </li>
	              <!-- Menu Body -->
	              <li class="user-body">
	                <div class="row">
	                  <div class="col-xs-4 text-center">
	                    <a href="#">Followers</a>
	                  </div>
	                  <div class="col-xs-4 text-center">
	                    <a href="#">Sales</a>
	                  </div>
	                  <div class="col-xs-4 text-center">
	                    <a href="#">Friends</a>
	                  </div>
	                </div>
	                <!-- /.row -->
	              </li>
	              <!-- Menu Footer-->
	              <li class="user-footer">
	                <div class="pull-left">
	                  <a href="#" class="btn btn-default btn-flat">Profile</a>
	                </div>
	                <div class="pull-right">
	                  <a href="${pageContext.servletContext.contextPath}/logout" class="btn btn-default btn-flat">Sign out</a>
	                </div>
	              </li>
	            </ul>
	          </li>
