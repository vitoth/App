<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="App.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="css/bootstrap.css" />
    <link rel="stylesheet" href="css/custom.css" />

    <script src="js/jquery-1.11.3.min.js"></script>

    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/bootstrap-table/1.9.1/bootstrap-table.min.css">

    <!-- Latest compiled and minified JavaScript -->
    <script src="//cdnjs.cloudflare.com/ajax/libs/bootstrap-table/1.9.1/bootstrap-table.min.js"></script>

    <!-- Latest compiled and minified Locales -->
    <script src="//cdnjs.cloudflare.com/ajax/libs/bootstrap-table/1.9.1/locale/bootstrap-table-zh-CN.min.js"></script>

    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" integrity="sha512-dTfge/zgoMYpP7QbHy4gWMEGsbsdZeCXz7irItjcC3sPUFtf0kuFbDz/ixG7ArTxmDjLXDmezHubeNikyKGVyQ==" crossorigin="anonymous">

    <!-- Optional theme -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css" integrity="sha384-aUGj/X2zp5rLCbBxumKTCw2Z50WgIr1vs/PFN4praOTvYXWlVyh2UtNUU0KAUhAX" crossorigin="anonymous">

    <!-- Latest compiled and minified JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js" integrity="sha512-K1qjQ+NcF2TYO/eI3M6v8EiNYZfA95pQumfvcVrTHtwQVDG+aHRqLi/ETn2uB+1JqwYqVG3LIvdm9lj6imS/pQ==" crossorigin="anonymous"></script>


   <%-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>--%>
    <link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>
    <script src="js/listgroup.min.js"></script>
    <script src="js/bic_calendar.js"></script>
    <link rel="stylesheet" href="css/bic_calendar.css" />
</head>
<body>
    <nav class="navbar navbar-default navbar-static-top">
        <div class="container">
            <form name="form1">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="#">App</a>
                </div>
                <div id="navbar" class="navbar-collapse collapse">
                    <ul class="nav navbar-nav">
                        <li><a href="Default.aspx"><span class="glyphicon glyphicon-home" aria-hidden="true"></span>Početna</a></li>
                    </ul>
                    <ul class="nav navbar-nav navbar-right">
                        <li><a href="#"><span class="glyphicon glyphicon-user" aria-hidden="true"></span><span>
                            <asp:Label ID="lblUsername" runat="server" Text="Prijava"></asp:Label></span></a></li>
                    </ul>
                </div>
                <!--/.nav-collapse -->
            </form>
        </div>
    </nav>
    <div class="container">
        <div class="row">
            <div id="alertPlaceholder"></div>
            <div class="col-md-2">
                <h4>Korisnici</h4>
                <div class="form-group">
                    <ul id="selectUser" class="list-group">
                    </ul>
                </div>
            </div>

            <div class="col-md-1">
                <button type="button" class="btn btn-success">Upiši</button>
                <button type="button" class="btn btn-danger">Briši</button>
            </div>
            <div class="col-md-8">
                <div id="calendar"></div>
                <h4>Odaberite datum</h4>
                <div class="form-group">
                    <input type="button" class="btn btn-block btn-default" value="Spremi" onclick="SaveEntry()" />
                </div>
            </div>
        </div>
        <hr />
    </div>


    <script>
        var entry;
        var users;
        var entries;

        var alertDanger = "alert-danger";
        var alertWarning = "alert-warning";
        var alertSuccess = "alert-success";
        var alertInfo = "alert-info";

        var entry;
        var users;
        var entries;

        var alertDanger = "alert-danger";
        var alertWarning = "alert-warning";
        var alertSuccess = "alert-success";
        var alertInfo = "alert-info";



        $(document).ready(function () {
            HideAlert();
            GetUsers();
            SetupCalendar()
            $('#selectUser').on('click', 'li', function () {
                GetEntries($(this).prop('id'));
            });

        });

        function SaveEntry() {
            entry = { Id: "", IdUser: "", SelectedDateStart: "", SelectedDateEnd: "" };
            entry.Id = 0;
            entry.IdUser = $('#selectUser').val();
            entry.SelectedDateStart = $('#datepickerStart').datepicker({ dateFormat: 'dd.MM.yyyy' }).val();
            entry.SelectedDateEnd = $('#datepickerEnd').datepicker({ dateFormat: 'dd.MM.yyyy' }).val();
            var jsoned = JSON.stringify(entry);
            console.log(jsoned);
            $.ajax({
                type: "POST",
                url: "Default.aspx/SaveEntry", 
                data: "{jsone:'" + jsoned + "'}", 
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (t) { 
                    if (t.d != "error") {
                        ShowAlert(alertInfo, "Podaci spremljeni");
                    }
                    else {
                        ShowAlert(alertDanger, "Greška u spremanju podataka! Molimo pokušajte ponovno.");
                    }

                },
                error: function (response) {
                    if (response == "error") {
                        ShowAlert(alertDanger, "Greška u spremanju podataka! Molimo pokušajte ponovno.");
                    }
                    else {
                        var responseTextObject = jQuery.parseJSON(response.responseText);
                        ShowAlert(alertDanger, "Greška u spremanju podataka! Molimo pokušajte ponovno.")
                    }
                }
            });
        }

        function GetUsers() {
            $.ajax({
                type: "POST",
                url: "Default.aspx/GetUsers", 
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {
                    if (msg.d != "error") {
                        users = jQuery.parseJSON(msg.d);
                        $.each(users, function (i, item) { 
                            $('#selectUser').append('<li class="list-group-item"' + 'id="' + item.Id + '">' + item.Name + '</li>');
                        });
                    }
                    else {
                        ShowAlert(alertDanger, "Greška u učitavanju podataka! Molimo pokušajte ponovno.");
                    }
                },
                error: function (response) {
                    var responseTextObject = jQuery.parseJSON(response.responseText);
                }
            });
        }

        function GetEntries(id) {
            $.ajax({
                type: "POST",
                url: "Default.aspx/GetEntries",
                data: "{'iduser':'"+id+"'}", 
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) { 
                    if (msg.d != "error") { 
                        entries = jQuery.parseJSON(msg.d);
                        $.each(entries, function (i, item) {
                            var date1 = convertNETDateTime(item.SelectedDateStart);
                            var date2 = convertNETDateTime(item.SelectedDateEnd);
                            var line = '<li id="d' + item.Id + '" OnClick="Delete(' + item.Id + ')">Od ' + FormatDate(date1) + " do " + FormatDate(date2) + ' (' + item.Username + ')</li>';
                            $('#data').append(line);
                            //
                        });
                    }
                    else {
                        ShowAlert(alertDanger, "Greška u učitavanju podataka! Molimo pokušajte ponovno.");
                    }
                },
                error: function (response) {
                    var responseTextObject = jQuery.parseJSON(response.responseText);
                }
            });
        }

        function Delete(id) {
            var r = confirm("Jeste li sigurni da želite obrisati ovaj redak?");
            var IdToDelete = id;
            if (r == true) {
                $.ajax({
                    type: "POST",
                    url: "Default.aspx/Delete",
                    data: '{"id":"' + id + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        if (msg.d != "error") {
                            ShowAlert(alertSuccess, "Uspješno obrisan!");
                            location.reload();
                        }
                        else {
                            ShowAlert(alertDanger, "Greška u brisanju podataka! Molimo pokušajte ponovno.");
                        }
                    },
                    error: function (response) {
                        var responseTextObject = jQuery.parseJSON(response.responseText);
                    }
                });
            } else {
                return;
            }
        }

        function HideAlert() {
            $('#alertPlaceholder').hide();
        }

        function ShowAlert(aType, aText) {
            $('#alertPlaceholder').append('<div class="alert alert-dismissible ' + aType + '" role="alert"><button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>' + aText + '</div>')
            $('#alertPlaceholder').show();
        }

        function SetupCalendar() {

            document.addEventListener('bicCalendarSelect', function (e) {
                alert(' You selected from ' + e.detail.dateFirst + 'to' + e.detail.dateLast + '.');

            });

            var monthNames = ["Siječanj", "Veljača", "Ožujak", "Travanj", "Svibanj", "Lipanj", "Srpanj", "Kolovoz", "Rujan", "Listopad", "Studeni", "Prosinac"];

            var dayNames = ["P", "U", "S", "Č", "P", "S", "N"];

            var events = [
                {
                    date: "28/10/2015",
                    title: '',
                    link: '',
                    color: '',
                    content: '',
                    class: '',
                }
            ];

            $('#calendar').bic_calendar({
                //list of events in array
                events: events,
                //enable select
                enableSelect: true,
                //enable multi-select
                multiSelect: true,
                //set day names
                dayNames: dayNames,
                //set month names
                monthNames: monthNames,
                //show dayNames
                showDays: true,
                //set ajax call
                reqAjax: {
                    type: 'get',
                    url: 'http://bic.cat/bic_calendar/index.php'
                }
                //set popover options
                //popoverOptions: {}
                //set tooltip options
                //tooltipOptions: {}
            });
        }


        function convertNETDateTime(sNetDate) {
            if (sNetDate == null) return null;
            if (sNetDate instanceof Date) return sNetDate;
            var r = /\/Date\(([0-9]+)\)\//i
            var matches = sNetDate.match(r);
            if (matches.length == 2) {
                return new Date(parseInt(matches[1]));
            }
            else {
                return sNetDate;
            }
        }

        function FormatDateTime(date) {
            var d = new Date(date);
            return d.getDate() + "." + (d.getMonth() + 1) + "." + d.getFullYear() + " " + d.getHours() + ":" + ('0' + d.getMinutes()).slice(-2) + ":" + ('0' + d.getSeconds()).slice(-2);
        }

        function FormatDate(date) {
            var d = new Date(date);
            return d.getDate() + "." + (d.getMonth() + 1) + "." + d.getFullYear();
        }

    </script>

</body>
</html>
