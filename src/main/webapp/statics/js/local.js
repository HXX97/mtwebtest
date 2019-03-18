function logout() {
    if (window.confirm('Are you sure to log out?') == true) {
        window.location.href = '/user/logout'
    }
}



function init(username){

    if(username!="null"){
        var userDrop = document.getElementById("userDrop");
        userDrop.classList.remove("dropdown");

        userDrop.innerHTML='<a href="#" class="dropdown-toggle" data-toggle="dropdown">'+username+'<strong class="caret"></strong></a>\n' +
            '                            <ul class="dropdown-menu">\n' +
            '                                <li>\n' +
            '                                    <a href="/user/edit/'+username+'">个人资料</a>\n' +
            '                                </li>\n' +
            '                                <li>\n' +
            '                                    <a href="javascript:void(0)" onclick="logout()">登出</a>\n' +
            '                                </li>\n' +
            '                            </ul>';

        //userDrop.innerHTML="<a href='javascript:void(0)' onclick='logout()'>"+username+":注销</a>"
    }
}