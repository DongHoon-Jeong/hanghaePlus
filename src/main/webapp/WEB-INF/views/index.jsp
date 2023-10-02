<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <script src="/js/jquery.js"></script>
    <title>Calculator</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }

        .calculator {
            width: 300px;
            margin: 0 auto;
            border: 1px solid #ccc;
            background-color: #f9f9f9;
            padding: 10px;
            border-radius: 5px;
        }

        .calculator input[type="text"] {
            width: 100%;
            font-size: 20px;
            padding: 5px;
            margin-bottom: 10px;
        }

        .calculator button {
            width: 45px;
            height: 45px;
            font-size: 20px;
            margin: 5px;
            cursor: pointer;
        }

        .calculator button.space {
            width: 45px;
            height: 45px;
            font-size: 20px;
            margin: 5px;
            cursor: pointer;
            background-color: #ccc;
            border: none;
        }

        .calculator button.double {
            width: 100%; /* 두 칸짜리 버튼의 전체 너비로 설정 */
        }

        .calculator button.clear {
            background-color: #ff5722;
            color: white;
        }
    </style>
</head>
<body>
    <div class="calculator">
        <input type="text" id="display" value = 0 disabled>
        <div>
            <button onclick="appendToDisplay('7')">7</button>
            <button onclick="appendToDisplay('8')">8</button>
            <button onclick="appendToDisplay('9')">9</button>
            <button onclick="operator('+')">+</button>
            <button onclick="operator('-')">-</button>
            <button onclick="appendToDisplay('4')">4</button>
            <button onclick="appendToDisplay('5')">5</button>
            <button onclick="appendToDisplay('6')">6</button>
            <button onclick="operator('*')">*</button>
            <button onclick="operator('/')">/</button>
            <button onclick="appendToDisplay('1')">1</button>
            <button onclick="appendToDisplay('2')">2</button>
            <button onclick="appendToDisplay('3')">3</button>
            <button onclick="clearLastDisplay()" class="clear">C</button>
            <button onclick="clearAllDisplay()" class="clear">AC</button>
            <button onclick="appendToDisplay('0')">0</button>
            <button onclick="appendToDisplay('.')">.</button>
            <button onclick="calculateResult()" class="double">=</button>
        </div>
    </div>
</body>
</html>

<script>

    // body에 keydown 이벤트 리스너 추가
    document.body.addEventListener('keydown', function(event) {
        // 키패드 입력이 숫자인 경우
        if (/^\d$/.test(event.key)) {
            appendToDisplay(event.key);
        }
    });

    //모든 계산식
    var allDisplay = "";

    //최근에 입력된 연산자
    var lastOperator = "";

    //계산 직후 여부
    var lastCalculate = false;

    //숫자입력
    function appendToDisplay(value) {

        if($("#display").val() == "Infinity" || $("#display").val() == "숫자아님"){
            alert("초기화 후 진행해주세요.");
            return;
        }

        //계산 직후에는 숫자를 눌러서 진행 불가, 초기화 혹은 연산자를 눌러서 진행해야함.
        if(lastCalculate){
            return;
        }

        if(value == 0 && $("#display").val() == 0){
            return;
        }else{
            if(value != 0 && $("#display").val() == 0){
                $("#display").val(value);
            }else{
                $("#display").val(addComma(deleteComma($("#display").val())+value));
            }
            allDisplay += value;
        }
    }

    //C기능
    function clearLastDisplay() {
        if(lastCalculate == true){
            clearAllDisplay();
            return;
        }
        
        if(allDisplay != ""){
            allDisplay = allDisplay.substring(0, allDisplay.length - deleteComma($("#display").val()).length);
        }
        lastCalculate = false;
        $("#display").val("0");
    }

    //AC 기능
    function clearAllDisplay() {
        allDisplay = "";
        lastOperator = "";
        lastCalculate = false;
        $("#display").val("0");
    }

    //계산 결과
    function calculateResult() {

        if(lastOperator == "" || lastOperator == null){
            alert("연산자를 입력해주세요.");
            return;
        }

        lastCalculate = true;
        lastOperator = "";

        try {
            var result = Math.floor(eval(allDisplay));

            if(result.toString().length > 10){
                $("#display").val("Infinity")
                return;
            }
            $("#display").val(addComma(result));
        } catch (error) {
            $("#display").val("숫자아님")
        }
    }

    //연산자
    function operator(type){

        if($("#display").val() == "Infinity" || $("#display").val() == "숫자아님"){
            alert("초기화 후 진행해주세요.");
            return;
        }

        //계산식의 마지막이 숫자가 아니면, 제거후 다시 연산자를 붙인다
        if(isNaN(allDisplay.slice(-1))){
            allDisplay = allDisplay.substring(0, allDisplay.length-1);
        }
        allDisplay += type;
        lastOperator = type;
        lastCalculate = false;
        $("#display").val("0");
    }

    function addComma(price) {
        return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
    }

    function deleteComma(price){
        return price.replace(/,/g, "");
    }

</script>