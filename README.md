# FoodTracker

FoodTracker records the calories you eat every day by providing food/ingredients. Calories and nutrion information is obtained from https://api.calorieninjas.com/v1.  There are 3 major components in the app, `Summary`, 'LogBook' and 'add new tiem'. User can add food/ingredients with weight information into the table. 'Summary' shows the 10-day-average and a bart chart which show the last 10 days/entries. `plus` button next to Summary allows user to add the food/ingredients for the current day. and `LogBook` gives the total calories record of each day.

## Implementation
App entry point is `SummaryViewController`. The  

## How to build
1. Pull the repository to local path.
2. Open `FoodTracker.xcodeproj` in xcode
3. Select simulator/real phone (iOS >= 12.0) and select Run under menu Product

## Requirements
Xcode 14.x
Swift 5.7
iOS >= 12.0 (Use as an **Embedded** Framework)

## License
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
