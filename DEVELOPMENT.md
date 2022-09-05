# SRE_API
This simple GO build with Docker
##
How to get first start:
```bash
git clone https://github.com/XackiGiFF/sre_task.git
```
```bash
cd ./sre_task
```
```bash
rm -Rf ./db
```
```bash
docker-compose up --build
```
# How to use API:
| **PATH**                             | **Description**                | **Metods**			| **Works?** |
|--------------------------------------|--------------------------------|-----------------------|------------|
| `/contacts/search/`                  | SearchContact                 	| `POST`            	|    YES     |
| `/contacts/get-all/`                 | GetAllContacts                	| `POST`        		|    YES     |
| `/contacts/new/`                     | CreateNewContact		        | `DELETE`        		|    YES     |
| `/contacts/delete-by-number/`        | DeleteContactByNumber          | `DELETE`     			|    YES     |
| `/contacts/delete-all/`              | DeleteAllContacts        	    | `DELETE`       		|    YES     |
| `/info/`                             | Info                           | `GET`                 |    YES     |


## Fix bugs:

### In docker-compose.yml
- Set `version: '3.8'` to `version: '2.3'`
- Add code in `phonebook_backend service`:
```yaml
    depends_on:
      phonebookdb:
        condition: service_healthy
    
```
And
```yaml
    ports:
     - '8000:8000'
```
For get API on 8000.

- Add code in `phonebookdb service`:
```yaml
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U jim -d phonebook -h localhost -p 5432"]
      interval: 5s
      timeout: 120s
      retries: 25
```
This need for start **SRE_API** `phonebook_backend service` after `phonebookdb service` (This service was crushing, cause it was loaded before phonebookdb service)
___
And
```yaml
    environment:
      POSTGRES_USER: jim
      POSTGRES_PASSWORD: sdljflsdjfe
      POSTGRES_DB: phonebook
```
```yaml
    volumes: 
      ./sql/docker_postgres_init.sql:/docker-entrypoint-initdb.d/docker_postgres_init.sql
```
For MAKE & FILL test string to SQL database. There\`s response from app:
```json
{
    "type":"success",
    "data":[{
        "phonenumber":"Yurij Dyatlov",
        "fullname":"Kazan, st.Komsomolskaya d.53 kv.22",
        "address":"312997789",
        "email":"y.dyatlov@ygoogle.com"}],
    "message":""
}
```
___
### In /Dockerfile:

- Uncomment:
```Dockerfile
FROM golang:alpine as builder
```
and
```Dockerfile
ENV GO111MODULE=on
```
# For correct job we need delete /db default folder for enable SQL scripts.

