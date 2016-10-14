<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="PokeDexWeb._default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <!-- metadata -->
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <!-- Vue.js -->
    <script src="Scripts/Vue/vue.min.js"></script>
    <!-- Bootstrap CSS -->
    <link href="Scripts/Bootstrap/css/bootstrap.min.css" rel="stylesheet" />
    <link href="Scripts/Bootstrap/css/bootstrap-theme.min.css" rel="stylesheet" />
    <!-- jQuery -->
    <script src="Scripts/jQuery/jquery-3.1.1.min.js"></script>
    <!-- Bootstrap -->
    <script src="Scripts/Bootstrap/js/bootstrap.min.js"></script>
    <!-- My stylesheet -->
    <style type="text/css">
        body {
            font-family: "Microsoft JhengHei",PMingLiU, sans-serif;
        }
    </style>
    <title>精靈寶可夢圖鑑查詢系統</title>
</head>
<body>
    <form id="form1" runat="server">
        <nav class="navbar navbar-inverse" role="navigation">
            <div class="container-fluid">
                <a class="navbar-brand" href="/">寶可夢圖鑑查詢</a>
            </div>
        </nav>
        <div class="container">
            <div class="col-xs-12 col-md-3 hidden-xs">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <table class="table">
                            <tr>
                                <td>No.</td>
                                <td>Name</td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
            <div class="col-xs-12 col-md-9" id="content">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        詳細資料
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
