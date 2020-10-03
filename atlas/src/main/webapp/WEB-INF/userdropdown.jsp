<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

	          <!-- User Account Menu -->
	          <li class="dropdown user user-menu">
	            <!-- Menu Toggle Button -->
	            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
	              <!-- The user image in the navbar-->
	              <img src="/userimg/${user.profileImage}" class="user-image" alt="**">
	              <!-- hidden-xs hides the username on small devices so only the image appears. -->
	              <span class="hidden-xs">${user.fullName}</span>
	            </a>
	            <ul class="dropdown-menu">
	              <!-- The user image in the menu -->
	              <li class="user-header">
	                <img src="/userimg/${user.profileImage}" class="img-circle" alt="User Image">
	
	                <p><small>${user.fullName}</small><small>${user.username}</small></p>
	              </li>
	              <!-- Menu Body -->
	              <li class="user-footer">
	                <div class="pull-left">
						
						<security:authorize access="hasRole('ROLE_ADMIN')">
						   <a href="/users" target="NEWPAGE" class="btn btn-default btn-flat">Usuários</a>
						   <a href="/user/${user.id}" target="NEWPAGE" class="btn btn-default btn-flat">Perfil</a>
						</security:authorize>
						
						<security:authorize access="hasRole('ROLE_USER')">
						   <a href="/user/${user.id}" target="NEWPAGE" class="btn btn-default btn-flat">Perfil</a>
						</security:authorize>
							                  
	                </div>
	                <div class="pull-right">
	                  <a href="/logout" class="btn btn-default btn-flat">Sair</a>
	                </div>
	              </li>
	            </ul>
	          </li>
