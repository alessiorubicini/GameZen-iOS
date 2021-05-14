

# GameZen Backend API service

Questo documento fornisce informazioni in merito alle API della piattaforma GameZen utilizzate
dalle app mobile per l'interazione con il database.

# Tecnologie




# Rotte

## Utenti

### Autenticazione

**Descrizione**
Il client effettua il login autenticandosi con nome utente e password. Il server verifica le
credenziali nel database e fornisce l'accesso o meno. La password utilizzata per l'accesso è già
convertita in MD5 lato client per motivi di sicurezza.

**Percorso**
`POST /GameZen/api/users/login.php`

**Headers**
`token: str`

**Body**
```json
{
	"username": "string",
	"password": "string"
}
```

**Status code**
- 200: user logged successfully
- 401: incorrect credentials
- 403: user banned
- 404: user not found
- 500: internal server error


