# Feature Request
## 🎯 The Goal
Build a simple command-line interface (CLI) tool in Python that allows a user to get the current weather for a specified city.

The tool should:
1. Accept a city name as an argument.

2. Use the free Open-Meteo API to fetch the current temperature.

3. Print the result to the console in a clean, human-readable format.

4. Handle potential errors gracefully (e.g., city not found, API down).

## 🎨 Inspiration & Examples
_There are no specific examples for this yet, as it's our first tool. We will establish the patterns with this feature._

## 📚 Required Knowledge
- **Open-Meteo Geocoding API:** Used to find the latitude and longitude for a given city.
    - https://open-meteo.com/en/docs/geocoding-api

- **Open-Meteo Weather API:** Used to get the weather forecast for a given latitude and longitude.
    - https://open-meteo.com/en/docs

- **Python's `argparse` library:** For creating the CLI.
    - https://docs.python.org/3/library/argparse.html

- **Python's `requests` library:** For making HTTP requests.
    - https://requests.readthedocs.io/en/latest/

## ⚠️ Potential Pitfalls & Gotchas
- The Open-Meteo API is a two-step process: first, you must get the coordinates for a city, then you use those coordinates to get the weather.

- The API returns a lot of data. We only care about the `current_weather` object and specifically the `temperature` field.

- Error handling is crucial. The tool should provide a clear message if the city can't be found by the Geocoding API.