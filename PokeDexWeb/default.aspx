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
    <link href="Scripts/Bootstrap/css/bootstrap-select.min.css" rel="stylesheet" />
    <link href="Scripts/Bootstrap/css/bootstrap-theme.min.css" rel="stylesheet" />
    <!-- jQuery -->
    <script src="Scripts/jQuery/jquery-3.1.1.min.js"></script>
    <!-- Bootstrap -->
    <script src="Scripts/Bootstrap/js/bootstrap.min.js"></script>
    <script src="Scripts/Bootstrap/js/bootstrap-select.min.js"></script>
    <!-- My stylesheet -->
    <link href="Style/attr-span.css" rel="stylesheet" />
    <style type="text/css">
        td.status-title {
            background-color: #30a7d7;
            color: #FFF;
            text-align: center;
            width: 40%;
        }

        table.stats th {
            background-color: #87c3e8;
            text-align: center;
        }

        table.stats td.type {
            background-color: #a4a4a4;
            text-align: center;
            width: 15%;
        }

        table.stats td.stats-value {
            text-align: center;
            width: 15%;
        }

        table.ability th.type {
            background-color: #87c3e8;
            text-align: center;
            width: 25%;
        }

        table.ability th.name {
            width: 25%;
        }

        .no-margin {
            margin: 0px;
        }

        .no-padding {
            padding: 0px;
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
            <!-- col-md-3 -->
            <div class="col-xs-12 col-md-3">
                <div class="panel panel-default">
                    <div class="panel-heading">妙蛙種子</div>
                    <div class="panel-body">
                        <div class="form-group">
                            <select class="selectpicker form-control">
                                <option value="normal">一般型態</option>
                            </select>
                        </div>
                        <div class="thumbnail no-margin">
                            <img src="Images/Dex/001.png" />
                        </div>
                    </div>
                </div>
                <!-- 基本資料 -->
                <div class="panel panel-default">
                    <div class="panel-heading">基本資料</div>
                    <table class="table table-bordered">
                        <tr>
                            <td class="status-title">圖鑑編號</td>
                            <td>001</td>
                        </tr>
                        <tr>
                            <td class="status-title">日文名</td>
                            <td>フシキダネ</td>
                        </tr>
                        <tr>
                            <td class="status-title">英文名</td>
                            <td>Bulbasaur</td>
                        </tr>
                        <tr>
                            <td class="status-title">屬性</td>
                            <td>
                                <div class="pokemon-attributes background-color-grass col-xs-6">草</div>
                                <div class="pokemon-attributes background-color-poison col-xs-6">毒</div>
                            </td>
                        </tr>
                        <tr>
                            <td class="status-title">身高</td>
                            <td>0.7m</td>
                        </tr>
                        <tr>
                            <td class="status-title">體重</td>
                            <td>6.9kg</td>
                        </tr>
                    </table>
                </div>
                <!-- 蛋 -->
                <div class="panel panel-default">
                    <div class="panel-heading">蛋相關</div>
                    <table class="table table-bordered">
                        <tr>
                            <td class="status-title">孵化步數</td>
                            <td>5120步</td>
                        </tr>
                        <tr>
                            <td class="status-title">蛋群</td>
                            <td>怪獸類、植物類</td>
                        </tr>
                    </table>
                </div>
            </div>
            <!-- col-md-9 -->
            <div class="col-xs-12 col-md-9" id="content">
                <!-- 數值 -->
                <div class="panel panel-default">
                    <div class="panel-heading">
                        數值資料
                    </div>
                    <table class="table table-bordered stats">
                        <tr>
                            <th>能力</th>
                            <th colspan="2">種族值</th>
                            <th>努力值</th>
                        </tr>
                        <tr>
                            <td class="type">HP</td>
                            <td>
                                <div class="progress no-margin">
                                    <div class="progress-bar" role="progressbar" aria-valuenow="45" aria-valuemin="0" aria-valuemax="255" style="width: 17.6%;">
                                        <span class="sr-only">45</span>
                                    </div>
                                </div>
                            </td>
                            <td class="stats-value">45</td>
                            <td class="stats-value"></td>
                        </tr>
                        <tr>
                            <td class="type">攻擊</td>
                            <td>
                                <div class="progress no-margin">
                                    <div class="progress-bar" role="progressbar" aria-valuenow="49" aria-valuemin="0" aria-valuemax="255" style="width: 19.2%;">
                                        <span class="sr-only">49</span>
                                    </div>
                                </div>
                            </td>
                            <td class="stats-value">49</td>
                            <td class="stats-value"></td>
                        </tr>
                        <tr>
                            <td class="type">防禦</td>
                            <td>
                                <div class="progress no-margin">
                                    <div class="progress-bar" role="progressbar" aria-valuenow="49" aria-valuemin="0" aria-valuemax="255" style="width: 19.2%;">
                                        <span class="sr-only">49</span>
                                    </div>
                                </div>
                            </td>
                            <td class="stats-value">49</td>
                            <td class="stats-value"></td>
                        </tr>
                        <tr>
                            <td class="type">特攻</td>
                            <td>
                                <div class="progress no-margin">
                                    <div class="progress-bar" role="progressbar" aria-valuenow="65" aria-valuemin="0" aria-valuemax="255" style="width: 25.5%;">
                                        <span class="sr-only">65</span>
                                    </div>
                                </div>
                            </td>
                            <td class="stats-value">65</td>
                            <td class="stats-value">1</td>
                        </tr>
                        <tr>
                            <td class="type">特防</td>
                            <td>
                                <div class="progress no-margin">
                                    <div class="progress-bar" role="progressbar" aria-valuenow="65" aria-valuemin="0" aria-valuemax="255" style="width: 25.5%;">
                                        <span class="sr-only">65</span>
                                    </div>
                                </div>
                            </td>
                            <td class="stats-value">65</td>
                            <td class="stats-value"></td>
                        </tr>
                        <tr>
                            <td class="type">速度</td>
                            <td>
                                <div class="progress no-margin">
                                    <div class="progress-bar" role="progressbar" aria-valuenow="45" aria-valuemin="0" aria-valuemax="255" style="width: 17.6%;">
                                        <span class="sr-only">45</span>
                                    </div>
                                </div>
                            </td>
                            <td class="stats-value">45</td>
                            <td class="stats-value"></td>
                        </tr>
                    </table>
                </div>
                <!-- 特性 -->
                <div class="panel panel-default">
                    <div class="panel-heading">特性</div>
                    <table class="table table-bordered ability">
                        <tr>
                            <th class="type">特性一</th>
                            <th class="name">茂盛</th>
                            <th class="name">しんりょく</th>
                            <th class="name">Overgrow</th>
                        </tr>
                        <tr>
                            <td colspan="4">HP剩下最大HP的1/3以下時，草系技能的威力變成1.5倍。</td>
                        </tr>
                        <tr>
                            <th class="type">隱藏特性</th>
                            <th>葉綠素</th>
                            <th>ようりょくそ</th>
                            <th>Chlorophyll</th>
                        </tr>
                        <tr>
                            <td colspan="4">晴天時，速度變成2倍。</td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
