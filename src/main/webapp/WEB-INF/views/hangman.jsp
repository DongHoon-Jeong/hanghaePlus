<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <script src="/js/jquery.js"></script>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>hangman game</title>
    <style>
        /* reset */
        h1,
        h2,
        h3,
        h4,
        h5,
        h6,
        p,
        div {
            padding: 0;
            margin: 0;
        }

        li,
        ul {
            list-style: none;
        }

        section {
            text-align: center;
        }

        .title {
            font-size: 32px;
            font-weight: 600;
            margin-bottom: 30pxs;

        }

        .subTitle {
            font-size: 18px;
            font-weight: 500;
        }

        .description {
            font-size: 25px;
            margin-top: 30px;
            margin-bottom: 50px;

        }

        .subjects {
            font-size: 25px;
            color: orangered;
            font-weight: 700;
        }


        #alphabet {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
        }

        #alphabet li {
            width: 30px;
            height: 30px;
            line-height: 30px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
            margin: 0 5px 5px;
            font-weight: bold;
            cursor: pointer;

        }

        #alphabet li.active {
            color: red;
        }

        canvas {
            border: 1px dashed #ddd;
            margin-bottom: 15px;
        }

        #my-word {
            display: flex;
            justify-content: center;
        }
        #my-word li {
            font-size: 25px;
            margin: 0 5px;
        }
        #selectWord {
            display: flex;
            justify-content: center;
        }
        #selectWord li {
            font-size: 25px;
            margin: 0 5px;
        }
        #mylives {
            color: brown;
            font-weight: bold;
            font-size: 25px;
            margin-bottom: 15px;
        }

        #answer {
            color: black;
            font-weight: bold;
            font-size: 25px;
            margin-bottom: 15px;
        }
    </style>
</head>

<body>
    <section>
        <p class="title">Hangman</p>
        <div id="buttons">

        </div>
        <div id="hold"></div>
        <div id="mylives"></div>
        <div id="answer"></div>
        <canvas id="stickman"></canvas>
        <div>
            <button id="reset">play again</button>
        </div>




    </section>
</body>

</html>
<script>

var alphabet = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'];

window.onload = function () {

    var hangmanWords1;
    var hangmanWords2;
    var hangmanWords3;
    var wordArray = [];
    var word;
    var guess;
    var guesses = [];
    var lives;
    var counter;
    var space;

    // 요소 잡기
    var showLives = document.getElementById('mylives');
    var showAnswer = document.getElementById('answer');


    // 구조를 만들어 줘야한다.

    var buttons = function () {
        myButtons = document.getElementById('buttons');
        letters = document.createElement('ul')

        for (var i = 0; i < alphabet.length; i++) {
            letters.id = "alphabet";
            list = document.createElement('li');
            list.id = 'letter';
            list.innerHTML = alphabet[i];
            check();
            myButtons.appendChild(letters);
            letters.appendChild(list);
        }
    }

     // 3개 단어
     wordSelect = function () {
        wordHolder = document.getElementById('hold');
        correct = document.createElement('ul');
        correct.setAttribute('id', 'selectWord');
        for (var i = 0; i < wordArray.length; i++) {
            console.log(wordArray[i]);
            guess = document.createElement('li');
            guess.setAttribute('class', 'selectWords');
            guess.innerHTML = "<button onclick=funcSelctWord('"+wordArray[i]+"')>"+wordArray[i]+"</button>";
            guesses.push(guess);
            wordHolder.appendChild(correct)
            correct.appendChild(guess);
        }
    }

    funcSelctWord = function (paramWord) {
        word = paramWord;
        guesses = [];
        $("#selectWord").remove();
        result();
    }

     // 단어 빈칸 만들기 (구조를 그려준다.)
     result = function () {
        wordHolder = document.getElementById('hold');
        correct = document.createElement('ul');
        correct.setAttribute('id', 'my-word');
        for (var i = 0; i < word.length; i++) {
            guess = document.createElement('li');
            guess.setAttribute('class', 'guess');
            if (word[i] == "-") {
                guess.innerHTML = "-";
                space = 1;
            } else {
                guess.innerHTML = "_"
            }
            guesses.push(guess);
            wordHolder.appendChild(correct)
            correct.appendChild(guess);
        }
    }

    // 화면에 차례대로 보일 수 있게 그려주고 있다.
    // 생명 (기회) 그려주기
    comments = function () {
        showLives.innerHTML = "You have " + lives + " lives";
        showAnswer.innerHTML = "";

        if(word != "" && word != null){
            if (lives < 1) {
                showLives.innerHTML = "Game Over";
                showAnswer.innerHTML = "정답은 = "+word;
                word = "";
                break;
            }
            for (var i = 0; i < guesses.length; i++) {
                if (counter + space === guesses.length) {
                    showLives.innerHTML = "you win!"
                    showAnswer.innerHTML = "정답은 = "+word;
                    word = "";
                    break;
                }
            }
        }
    }

    // 행맨 그려주기
    var animate = function () {
        var drawMe = lives;
        drawArray[drawMe]();
    }

    canvas = function () {
        myStickman = document.getElementById('stickman');
        context = myStickman.getContext('2d');
        context.beginPath();
        context.strokeStyle = "#000000";
        context.lineWidth = 2;
    };

    head = function () {
        myStickman = document.getElementById('stickman');
        context = myStickman.getContext('2d');
        context.beginPath();
        context.arc(60, 25, 10, 0, Math.PI * 2, true);
        context.stroke();

    }

    draw = function ($pathFromx, $pathFromy, $pathTox, $pathToy) {
        context.moveTo($pathFromx, $pathFromy);
        context.lineTo($pathTox, $pathToy);
        context.stroke();
    }

    frame1 = function () {
        draw(0, 150, 150, 150)
    }

    frame2 = function () {
        draw(10, 0, 10, 600)
    }

    frame3 = function () {
        draw(0, 5, 70, 5)
    }

    frame4 = function () {
        draw(60, 5, 60, 15)
    }

    torso = function () {
        draw(60, 36, 60, 70)
    }

    rightArm = function () {
        draw(60, 46, 100, 50)
    }

    lefttArm = function () {
        draw(60, 46, 20, 50)
    }

    rightLeg = function () {
        draw(60, 70, 100, 100)
    }

    leftLeg = function () {
        draw(60, 70, 20, 100)
    }

    drawArray = [rightLeg, leftLeg, rightArm, lefttArm, torso, head, frame4, frame3];

    // 정답 체크
    check = function () {
        list.onclick = function () {
            if(word != "" && word != null){
                var guess = (this.innerHTML)
                this.setAttribute('class', 'active');
                this.onclick = 'null';
                for (var i = 0; i < word.length; i++) {
                    if (word[i] === guess) {
                        guesses[i].innerHTML = guess;
                        counter += 1;
                    }
                }
                var j = (word.indexOf(guess))
                if (j === -1) {
                    lives -= 1;
                    comments();
                    animate();
                } else {
                    this.setAttribute('style', 'display:none;');
                    comments();
                }
            }
        }
    }

    //플레이
    play = function () {
        hangmanWords1 = [
              "apple",
            "banana",
            "cherry",
            "orange",
            "grape",
            "lemon",
            "strawberry",
            "blueberry",
            "watermelon",
            "pineapple",
            "apricot",
            "peach",
            "plum",
            "kiwi",
            "pear",
            "mango",
            "papaya",
            "coconut",
            "fig"
        ];
        hangmanWords2 = [
            "lime",
            "nectarine",
            "blackberry",
            "raspberry",
            "cranberry",
            "avocado",
            "grapefruit",
            "cantaloupe",
            "honeydew",
            "tangerine",
            "persimmon",
            "boysenberry",
            "elderberry",
            "guava",
            "kiwifruit",
            "passionfruit",
            "pomegranate",
            "quince",
            "mulberry",
            "starfruit"
        ];
        hangmanWords3 = [
            "cucumber",
            "carrot",
            "potato",
            "tomato",
            "broccoli",
            "cauliflower",
            "asparagus",
            "lettuce",
            "spinach",
            "zucchini",
        ];

        for(var i=0; i<3; i++){
            if(i==0){
                wordArray[i] = hangmanWords1[Math.floor(Math.random() * hangmanWords1.length)];
            }else if(i==1){
                wordArray[i] = hangmanWords2[Math.floor(Math.random() * hangmanWords2.length)];
            }else{
                wordArray[i] = hangmanWords3[Math.floor(Math.random() * hangmanWords3.length)];
            }
        }

        buttons();
        word = "";
        guesses = [];
        lives = 8;
        counter = 0;
        space = 0;
        wordSelect();
        comments();
        canvas();

        draw(0, 150, 150, 150);
        draw(10, 0, 10, 600);
    }

    play();

    // reset
    document.getElementById('reset').onclick = function () {
        correct.parentNode.removeChild(correct);
        letters.parentNode.removeChild(letters);
        context.clearRect(0, 0, 400, 400);
        play();
    }

}
</script>