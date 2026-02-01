import google.auth
from google.auth.transport.requests import Request
from google.oauth2 import service_account

SERVICE_ACCOUNT_FILE = 'file.json'

# Scopes required for Cloud Messaging API
SCOPES = ['https://www.googleapis.com/auth/firebase.messaging']


def get_access_token():


    try:
        credentials, project = google.auth.default(scopes=SCOPES)
    except google.auth.exceptions.DefaultCredentialsError:
        credentials = service_account.Credentials.from_service_account_file(
            SERVICE_ACCOUNT_FILE, scopes=SCOPES
        )

    request = Request()
    credentials.refresh(request)
    return credentials.token


print("----")
print(get_access_token())

