#!/usr/bin/env python

import json
import requests
from datetime import datetime

WEATHER_CODES = {
    '113': '\u2600\ufe0f',
    '116': '\u26c5\ufe0f',
    '119': '\u2601\ufe0f',
    '122': '\u2601\ufe0f',
    '143': '\U0001f32b',
    '176': '\U0001f326',
    '179': '\U0001f327',
    '182': '\U0001f327',
    '185': '\U0001f327',
    '200': '\u26c8',
    '227': '\U0001f328',
    '230': '\u2744\ufe0f',
    '248': '\U0001f32b',
    '260': '\U0001f32b',
    '263': '\U0001f326',
    '266': '\U0001f326',
    '281': '\U0001f327',
    '284': '\U0001f327',
    '293': '\U0001f326',
    '296': '\U0001f326',
    '299': '\U0001f327',
    '302': '\U0001f327',
    '305': '\U0001f327',
    '308': '\U0001f327',
    '311': '\U0001f327',
    '314': '\U0001f327',
    '317': '\U0001f327',
    '320': '\U0001f328',
    '323': '\U0001f328',
    '326': '\U0001f328',
    '329': '\u2744\ufe0f',
    '332': '\u2744\ufe0f',
    '335': '\u2744\ufe0f',
    '338': '\u2744\ufe0f',
    '350': '\U0001f327',
    '353': '\U0001f326',
    '356': '\U0001f327',
    '359': '\U0001f327',
    '362': '\U0001f327',
    '365': '\U0001f327',
    '368': '\U0001f328',
    '371': '\u2744\ufe0f',
    '374': '\U0001f327',
    '377': '\U0001f327',
    '386': '\u26c8',
    '389': '\U0001f329',
    '392': '\u26c8',
    '395': '\u2744\ufe0f'
}

data = {}


weather = requests.get("https://wttr.in/?format=j1").json()


def format_time(time):
    return time.replace("00", "").zfill(2)


def format_temp(temp):
    return (hour['FeelsLikeC']+"\u00b0").ljust(3)


def format_chances(hour):
    chances = {
        "chanceoffog": "Fog",
        "chanceoffrost": "Frost",
        "chanceofovercast": "Overcast",
        "chanceofrain": "Rain",
        "chanceofsnow": "Snow",
        "chanceofsunshine": "Sunshine",
        "chanceofthunder": "Thunder",
        "chanceofwindy": "Wind"
    }

    conditions = []
    for event in chances.keys():
        if int(hour[event]) > 0:
            conditions.append(chances[event]+" "+hour[event]+"%")
    return ", ".join(conditions)


data['text'] = WEATHER_CODES[weather['current_condition'][0]['weatherCode']] + \
    " "+weather['current_condition'][0]['FeelsLikeC']+"\u00b0"

data['tooltip'] = f"<b>{weather['current_condition'][0]['weatherDesc'][0]['value']} {weather['current_condition'][0]['temp_C']}\u00b0</b>\n"
data['tooltip'] += f"Feels like: {weather['current_condition'][0]['FeelsLikeC']}\u00b0\n"
data['tooltip'] += f"Wind: {weather['current_condition'][0]['windspeedKmph']}Km/h\n"
data['tooltip'] += f"Humidity: {weather['current_condition'][0]['humidity']}%\n"
for i, day in enumerate(weather['weather']):
    data['tooltip'] += f"\n<b>"
    if i == 0:
        data['tooltip'] += "Today, "
    if i == 1:
        data['tooltip'] += "Tomorrow, "
    data['tooltip'] += f"{day['date']}</b>\n"
    data['tooltip'] += f"\u2b06\ufe0f {day['maxtempC']}\u00b0 \u2b07\ufe0f {day['mintempC']}\u00b0 "
    data['tooltip'] += f"\U0001f305 {day['astronomy'][0]['sunrise']} \U0001f307 {day['astronomy'][0]['sunset']}\n"
    for hour in day['hourly']:
        if i == 0:
            if int(format_time(hour['time'])) < datetime.now().hour-2:
                continue
        data['tooltip'] += f"{format_time(hour['time'])} {WEATHER_CODES[hour['weatherCode']]} {format_temp(hour['FeelsLikeC'])} {hour['weatherDesc'][0]['value']}, {format_chances(hour)}\n"


print(json.dumps(data))
