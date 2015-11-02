<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="App.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>App prijava</title>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>

    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" integrity="sha512-dTfge/zgoMYpP7QbHy4gWMEGsbsdZeCXz7irItjcC3sPUFtf0kuFbDz/ixG7ArTxmDjLXDmezHubeNikyKGVyQ==" crossorigin="anonymous">

    <!-- Optional theme -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css" integrity="sha384-aUGj/X2zp5rLCbBxumKTCw2Z50WgIr1vs/PFN4praOTvYXWlVyh2UtNUU0KAUhAX" crossorigin="anonymous">

    <!-- Latest compiled and minified JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js" integrity="sha512-K1qjQ+NcF2TYO/eI3M6v8EiNYZfA95pQumfvcVrTHtwQVDG+aHRqLi/ETn2uB+1JqwYqVG3LIvdm9lj6imS/pQ==" crossorigin="anonymous"></script>


    <link rel="stylesheet" href="css/login.css" />
</head>
<body>
    <div class="jumbotron vertical-center">
        <div class="container text-center">
            <form class="form-signin">
                <div id="alert_placeholder">
                </div>
                <input id="inputUsername" class="form-control" placeholder="Korisničko ime" />
                <input type="password" id="inputPassword" class="form-control" placeholder="Lozinka" />
                <div class="rememberChkbox">
                    <label>
                        <input type="checkbox" id="rememberChkbox">
                        Zapamti me
                    </label>
                </div>
                <button class="btn btn-lg btn-primary btn-block" onclick="login()">Prijava</button>
            </form>
        </div>
        <!-- /container -->
    </div>
    <!-- /vertical-center -->

    <!-- Include all compiled plugins (below), or include individual files as needed -->

    <%--<script src="js/bootstrap.min.js"></script>--%>

    
    <script>
        // login fukcija, kao parametre šaljemo username, password i rememberMe
        function login() {
            $.ajax({
                type: "POST",
                url: "Login.aspx/LoginUser", //funkciju u csu koju pozivamo dostupna je izvana jer tamo koristmio [webmethod]
                data: '{"username":"' + $('#inputUsername').val() + '", "password":"' + $('#inputPassword').val() + '", "rememberMe":"' + $('#rememberChkbox').prop('checked') + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (u) {
                    console.log(u.d);
                    if (u.d == 'error') {
                        // user nije nešto ispravno upisao
                        showalert('Pogrešno korisničko ime ili lozinka!', 'alert-danger');
                        $('#alert_placeholder').show();

                        
                    }
                    else {
                        // login je ok, preusmjeravamo ga na traženi URL
                        console.log(u.d);
                        window.location = u.d;
                    }
                },
                error: function (response) {
                    var responseTextObject = jQuery.parseJSON(response.responseText);
                    console.log(responseTextObject);
                }
            });
        }

        function showalert(message, alerttype) {
            $('#alert_placeholder').append('<div id="alertdiv" class="alert ' + alerttype + '"><a class="close" data-dismiss="alert">×</a><span>' + message + '</span></div>')
            setTimeout(function () {
                $("#alertdiv").remove();
            }, 1560);
        }
    </script>
</body>
</html>
