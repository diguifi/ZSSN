# ZSSN
Zombie Survival Social Network - The mighty test

## Setup
- Install the latest version of [Ruby](https://rubyinstaller.org/downloads/)
- Open your command prompt inside the project's folder
- Type `gem install rails`
- After Rails is installed, type `bundle install`
- After every dependency is installed type `rails db:migrate`
- Next give the database a simple seed, if you want, by running `rails db:seed`

## Run
Now you can run the server by typing: `rails s`
The default port is _3000_, you can check if it worked by accessing _"http://localhost:3000"_

## Test
First create a migration for the tests by running `rails db:migrate RAILS_ENV=test`
To run automated tests, execute `rails test`

## Usage
### Survivors
| Verb  | Endpoint            | Body                                                                                                                                                                                                                                               | Result                                                                          |
|------------|---------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------|
| **GET**    | /api/v1/survivors   | -                                                                                                                                                                                                                                                  | Returns a list of survivors                                                     |
| **GET**    | /api/v1/survivors/1 | -                                                                                                                                                                                                                                                  | Returns survivor of id 1                                                        |
| **POST**   | /api/v1/survivors   | `{`<br>`"name" : "string",`<br>`"age" : 1,`<br>`"gender" : 0,`<br>`"latitude" : "0.000",`<br>`"longitude" : "0.000",`<br>`"inventory_attributes":`<br> `{`<br>`"water" : 0,`<br>`"food" : 0,`<br>`"medication" : 0,`<br>`"ammo" : 0`<br>`}`<br>`}` | Creates new survivor                                                            |
| **PUT**    | /api/v1/survivors/1 | `{`<br>`"latitude" : "0.000",`<br>`"longitude" : "0.000"`<br>`}`                                                                                                                                                                                   | Updates survivor's position (these are the only attributes that can be updated) |
| **DELETE** | /api/v1/survivors/1 | -                                                                                                                                                                                                                                                  | Deletes survivor of id 1                                                        |
| **GET**  | /api/v1/survivors/1/inventory | -                                                                       | Returns the inventory of survivor with id 1 |

### Infection reports
|  Verb      | Endpoint                    | Body                                                                    | Result                              |
|------------|-----------------------------|-------------------------------------------------------------------------|-------------------------------------|
| **GET**    | /api/v1/infection_reports   | -                                                                       | Returns a list of infection reports |
| **GET**    | /api/v1/infection_reports/1 | -                                                                       | Returns infection report of id 1    |
| **POST**   | /api/v1/infection_reports   | `{`<br>`"survivor_reported_id":1,`<br>`"survivor_reporter_id":2`<br>`}` | Creates new infection report        |
| **DELETE** | /api/v1/infection_reports/1 | -                                                                       | Deletes infection report of id 1    |

### Trade system
|  Verb    | Endpoint      | Body                                                                                                                                                                                                                                                                          | Result                        |
|----------|---------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------|
| **PUT** | /api/v1/trade | `{`<br>`"survivor_one_items":`<br>`{`<br>`"survivor_id":3,`<br>`"water":0,`<br>`"food":0,`<br>`"medication":1,`<br>`"ammo":0`<br>`},`<br>`"survivor_two_items":`<br>`{`<br>`"survivor_id":4,`<br>`"water":0,`<br>`"food":0,`<br>`"medication":0,`<br>`"ammo":2`<br>`}`<br>`}` | Trade items between survivors |

### General Reports
| Verb    | Endpoint                      | Body | Result                                          |
|---------|-------------------------------|------|-------------------------------------------------|
| **GET** | /api/v1/reports/infecteds     | -    | Returns percentage of infected survivors        |
| **GET** | /api/v1/reports/non_infecteds | -    | Returns percentage of non infected survivors    |
| **GET** | /api/v1/reports/average_items | -    | Returns average amount of items with survivors |
| **GET** | /api/v1/reports/points_lost   | -    | Returns total points lost because of infections |

