<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
        <title></title>
        <script type="text/javascript">
            function IsValidDate(myDate) {
                var TR_DATE = /^([012]?\d|3[01])-([Jj][Aa][Nn]|[Ff][Ee][bB]|[Mm][Aa][Rr]|[Aa][Pp][Rr]|[Mm][Aa][Yy]|[Jj][Uu][Nn]|[Jj][u]l|[aA][Uu][gG]|[Ss][eE][pP]|[oO][Cc]|[Nn][oO][Vv]|[Dd][Ee][Cc])-(19|20)\d\d$/
                                return TR_DATE.test(myDate);
            }
            function test() {
                var TR_DATE = document.getElementById('TR_DATE');
                var isValid = IsValidDate(TR_DATE.value);
                if (isValid) {
                    alert('Correct format');
                }
                else {
                    alert('Incorrect format');
                }
                return isValid
            }


        </script>
</head>
<body>
        <input id="TR_DATE" type="text" />
     



</body>


</html>