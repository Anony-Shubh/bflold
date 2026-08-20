<!DOCTYPE html>
<html>
  <title>::KIMIS ::LOGIN</title>
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <link
    rel="stylesheet"
    href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
  />
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <style>
    .dimScreen {
      position: absolute;
      padding: 0;
      margin: 0;
      z-index: 999;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background-color: rgba(43, 45, 65, 0.8);
      filter: blur(10px);
    }

    .container {
      z-index: 9999999;
      position: absolute;
      left: 50%;
      top: 50%;
      transform: translate(-50%, -50%);
      /* width: fit-content; */
      background-color: white;
      margin: 6rem auto;
      border-radius: 20px;
      padding: 20px;
      max-width: 569px;
      width: 100%;
      box-shadow: 30px 30px #414863;
      @media (max-width: 590px) {
        width: 90%;
      }
    }
    .HeaderLabel {
      text-align: center;
      font-weight: 700;
      color: #182848;
      font-size: 18px;
    }
    .buttonMerun {
      background-image: linear-gradient(
        to right,
        #ff512f 0%,
        #dd2476 51%,
        #ff512f 100%
      );
    }
    .buttonMerun {
      display: inline-block;
      padding: 5px 10px;
      text-align: center;
      text-transform: uppercase;
      transition: 0.5s;
      background-size: 200% auto;
      color: white;
      box-shadow: rgba(0, 0, 0, 0.4) 0px 2px 4px,
        rgba(0, 0, 0, 0.3) 0px 7px 13px -3px,
        rgba(0, 0, 0, 0.2) 0px -3px 0px inset;
      border-radius: 20px;
      cursor: pointer;
      outline: none;
      border: none;
      text-decoration: none;
      font-weight: bold;
      width: 80px !important;
    }

    .buttonMerun:hover {
      background-position: right center; /* change the direction of the change here */
      color: #fff;
      text-decoration: none;
    }

    .buttonBlue {
      background-image: linear-gradient(
        to right,
        #1a2980 0%,
        #26d0ce 51%,
        #1a2980 100%
      );
    }
    .buttonBlue {
      padding: 5px 10px;
      text-align: center;
      text-transform: uppercase;
      transition: 0.5s;
      background-size: 200% auto;
      color: white;
      box-shadow: rgba(0, 0, 0, 0.4) 0px 2px 4px,
        rgba(0, 0, 0, 0.3) 0px 7px 13px -3px,
        rgba(0, 0, 0, 0.2) 0px -3px 0px inset;
      border-radius: 20px;
      display: inline-block;
      cursor: pointer;
      outline: none;
      border: none;
      text-decoration: none;
      font-weight: bold;
      width: 80px !important;
    }

    .buttonBlue:hover {
      background-position: right center; /* change the direction of the change here */
      color: #fff;
      text-decoration: none;
    }
    .head {
      text-align: center;
      margin-top: 20px;
    }
  </style>
  <body>
    <div class="dimScreen"></div>
    <div class="container">
      <p class="HeaderLabel">
        I understand that the Margin Money shall be sanctioned subject to
        eligibility, admissibility and availability of funds and it is not
        guaranteed or legally binding to receive the Margin Money.
      </p>
      <div style="margin: auto; width: 40%; padding-top: 20px">
        <a
          href="index.jsp"
          class="buttonMerun"
          style="width: fit-content; margin-right: 20px"
          >Cancel</a
        >
        <a href="../jsp/pmegponline.jsp" class="buttonBlue" style="width: fit-content">Ok</a>
      </div>
    </div>
    <div class="head">
      <h2>PMEGP Online Application</h2>
    </div>
  </body>
</html>
