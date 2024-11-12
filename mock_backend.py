#!/usr/bin/env python
# encoding: utf-8
from flask import Flask, jsonify, request
import threading,time

app = Flask(__name__)
app.debug = True

@app.route('/test')
def index():
    return jsonify({'name': 'alice',
                    'email': 'alice@outlook.com'})

@app.route('/marketplace', methods=['GET'])
def marketplace():
    data = {
        "filterOptions": [
            "Binance",
            "BIST",
            "LONG",
            "SHORT",
            "Positive Performance",
            "Negative Performance",
            "TeST"
        ],
        "signalPropertyIcons": {
            "gainRate": "chart.line.uptrend.xyaxis",
            "subscriberCount": "person.3",
            "marketType": "calendar",
            "term": "clock"
        },
        "signalCardList": [
            {
                "traderId": "11111",
                "signalId": "11111222",
                "traderName": "Osman",
                "signalName": "Osmanin mekani",
                "price": 95.9,
                "signalProperties": {
                    "gainRate": 2.6,
                    "subscriberCount": 1111,
                    "marketType": "BIST",
                    "termType": "Long"
                }
            },
            {
                "traderId": "22222",
                "signalId": "22222444",
                "traderName": "Haydar",
                "signalName": "Sopa bukucu",
                "price": 999.9,
                "signalProperties": {
                    "gainRate": -2.6,
                    "subscriberCount": 111,
                    "marketType": "Biance",
                    "termType": "Long"
                }
            },
            {
                "traderId": "33333",
                "signalId": "33333555",
                "traderName": "Trader Name 5",
                "signalName": "TestSignal Name 5",
                "price": 9,
                "signalProperties": {
                    "gainRate": 25.6,
                    "subscriberCount": 2,
                    "marketType": "BIST",
                    "termType": "Short"
                }
            },
            {
                "traderId": "44444",
                "signalId": "44444001",
                "traderName": "Sinan",
                "signalName": "100x icin buraya gel",
                "price": 4,
                "signalProperties": {
                    "gainRate": -12.6,
                    "subscriberCount": 999546,
                    "marketType": "BIST",
                    "termType": "Long"
                }
            },
            {
                "traderId": "55555",
                "signalId": "55555003",
                "traderName": "test",
                "signalName": "test test",
                "price": 4,
                "signalProperties": {
                    "gainRate": -2.6,
                    "subscriberCount": 111,
                    "marketType": "Biance",
                    "termType": "Short"
                }
            },
            {
                "traderId": "66666",
                "signalId": "66666003",
                "traderName": "demir",
                "signalName": "vedat",
                "price": 3,
                "signalProperties": {
                    "gainRate": 0.6,
                    "subscriberCount": 141,
                    "marketType": "Biance",
                    "termType": "Short"
                }
            },
            {
                "traderId": "77777",
                "signalId": "77777003",
                "traderName": "kadir",
                "signalName": "mehmet",
                "price": 0.9,
                "signalProperties": {
                    "gainRate": -66.6,
                    "subscriberCount": 43,
                    "marketType": "Biance",
                    "termType": "Long"
                }
            },
            {
                "traderId": "88888",
                "signalId": "88888003",
                "traderName": "abdullah",
                "signalName": "bekir trade",
                "price": 1,
                "signalProperties": {
                    "gainRate": 4,
                    "subscriberCount": 23,
                    "marketType": "BIST",
                    "termType": "Long"
                }
            },
            {
                "traderId": "99999",
                "signalId": "99999003",
                "traderName": "nizamettin",
                "signalName": "paranin adresi",
                "price": 1.9,
                "signalProperties": {
                    "gainRate": -5,
                    "subscriberCount": 65,
                    "marketType": "Biance",
                    "termType": "Long"
                }
            },
            {
                "traderId": "12222",
                "signalId": "12222003",
                "traderName": "kemal",
                "signalName": "buraya gel",
                "price": 3.9,
                "signalProperties": {
                    "gainRate": 62.6,
                    "subscriberCount": 32,
                    "marketType": "BIST",
                    "termType": "Short"
                }
            },
            {
                "traderId": "13333",
                "signalId": "13333003",
                "traderName": "haci",
                "signalName": "bedeva",
                "price": 94.9,
                "signalProperties": {
                    "gainRate": 25.6,
                    "subscriberCount": 32,
                    "marketType": "Biance",
                    "termType": "Short"
                }
            },
        ]
    }
    time.sleep(1)
    return jsonify(data)

@app.route('/signals', methods=['POST'])
def signals():
    data = request.get_json()
    user_id = data.get('userId')
    if user_id:
        response = {
            "signalPropertyIcons": {
                "gainRate": "chart.line.uptrend.xyaxis",
                "subscriberCount": "person.3",
                "marketType": "calendar",
                "term": "clock"
            },
            "signalCardList": [
                {
                    "traderId": "11111",
                    "signalId": "11111222",
                    "traderName": "Osman",
                    "signalName": "Osmanin mekani",
                    "price": 95.9,
                    "signalProperties": {
                        "gainRate": 2.6,
                        "subscriberCount": 1111,
                        "marketType": "BIST",
                        "termType": "Long"
                    }
                },
                {
                    "traderId": "22222",
                    "signalId": "22222444",
                    "traderName": "Haydar",
                    "signalName": "Sopa bukucu",
                    "price": 999.9,
                    "signalProperties": {
                        "gainRate": -2.6,
                        "subscriberCount": 111,
                        "marketType": "Biance",
                        "termType": "Long"
                    }
                },
                {
                    "traderId": "33333",
                    "signalId": "33333555",
                    "traderName": "Trader Name 5",
                    "signalName": "TestSignal Name 5",
                    "price": 9,
                    "signalProperties": {
                        "gainRate": 25.6,
                        "subscriberCount": 2,
                        "marketType": "BIST",
                        "termType": "Short"
                    }
                }
            ]
        }
    else:
        response = {
            'status': 'error',
            'message': 'ID is missing'
        }

    return jsonify(response)

@app.route('/signaldetail', methods=['POST'])
def signaldetail():
    data = request.get_json()
    signalId = data.get('signalId')
    if signalId:
        response = {
            "chart": [
                {
                    "xAxis": "2024-10-01",
                    "yAxis": 10.5
                },
                {
                    "xAxis": "2024-10-02",
                    "yAxis": 152.3
                },
                {
                    "xAxis": "2024-10-03",
                    "yAxis": 149.8
                },
                {
                    "xAxis": "2024-10-05",
                    "yAxis": 19.8
                },
                {
                    "xAxis": "2024-11-03",
                    "yAxis": 200
                }
            ],
            "info": [
                {
                    "title": "Stock Overview",
                    "infoMap": {
                        "Open": "150.0",
                        "Close": "152.3",
                        "High": "153.0",
                        "Low": "149.5"
                    }
                },
                {
                    "title": "Market Performance",
                    "infoMap": {
                        "Volume": "1.2M",
                        "Change": "+1.53%",
                        "MarketCap": "500B"
                    }
                }
            ]
        }

    else:
        response = {
            'status': 'error',
            'message': 'ID is missing'
        }

    return jsonify(response)

@app.route('/risksurvey', methods=['GET'])
def risksurvey():
    response = {
        "questionList": [
            {
                "number": 1,
                "question": "Question 1",
                "answers": [
                    "Answer 1"
                ]
            },
            {
                "number": 2,
                "question": "Bu soru ikinci sorudur?",
                "answers": [
                    "Answer 1",
                    "Answer 2",
                    "Answer 3"
                ]
            },
            {
                "number": 3,
                "question": "Bu bir deneme sorusudur?",
                "answers": [
                    "Bu birinci cevaptir",
                    "Bu ikinci cevaptir",
                    "bu ucuncu cevaptir"
                ]
            },
            {
                "number": 4,
                "question": "Question 4Question 4Question 4Question 4Question 4Question 4Question 4Question 4Question 4Question 4Question 4",
                "answers": [
                    "Answer 1"
                ]
            },
            {
                "number": 5,
                "question": "Bu soru son sorudur?",
                "answers": [
                    "Answer 1",
                    "Answer 2",
                    "Answer 3"
                ]
            }
        ]
    }

    return jsonify(response)

@app.route('/subscriptions', methods=['GET'])
def subscriptions():
    response = {
        "subscriptionList": [
            {
                "signalId": "13333003",
                "traderName": "traderName",
                "signalName": "signalName",
                "startDate": "2024.11.12",
                "status": "active"
            },
            {
                "signalId": "13333004",
                "traderName": "traderName4",
                "signalName": "signalName4",
                "startDate": "2024.11.12",
                "status": "active"
            },
            {
                "signalId": "13333005",
                "traderName": "traderName5",
                "signalName": "signalName5",
                "startDate": "2024.11.12",
                "endDate": "2024.12.12",
                "status": "expired"
            },
            {
                "signalId": "13333006",
                "traderName": "traderName6",
                "signalName": "signalName6",
                "startDate": "2024.11.12",
                "status": "pending"
            },
            {
                "signalId": "13333006",
                "traderName": "traderName7",
                "signalName": "signalName7",
                "startDate": "2024.11.12",
                "status": "pending"
            }
        ]
    }

    return jsonify(response)

app.run()