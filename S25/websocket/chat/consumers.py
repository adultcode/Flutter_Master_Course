import json

from channels.db import database_sync_to_async
from channels.generic.websocket import WebsocketConsumer
from asgiref.sync import async_to_sync

from chat.models import Todo


class ChatConsumer(WebsocketConsumer):
    online_user = 0
    # def __init__(self):
    #     self.online_user=0

    # def add_user(self):
    #     try:
    #         f = open("myfile.txt", "r+")
    #         # users = int(f.read())
    #         f.close()
    #         # users += 1
    #         f = open("myfile.txt", "w")
    #         # f.write(str(users))
    #
    #     except:
    #         f = open("myfile.txt", "r+")
    #         users = int(f.read())
    #         f.close()
    #         users += 1
    #         f = open("myfile.txt", "w")
    #         f.write(str(users))

    # def remove_user(self):
    #     try:
    #         f = open("myfile.txt", "x")
    #         f.write("1")
    #
    #     except:
    #         f = open("myfile.txt", "r+")
    #         users = int(f.read())
    #         f.close()
    #         users -= 1
    #         f = open("myfile.txt", "w")
    #         f.write(str(users))

    # def disconnect(self, code):
    #     self.online_user-=1
    #     self.send(text_data=json.dumps({
    #         'users': self.online_user
    #     }))
    def disconnect(self, code):
        print('disconnected')
        # self.disconnect()
    def connect(self):

        self.room_group_name = "test"
        self.online_user=self.online_user+1


        async_to_sync(self.channel_layer.group_add)(
            self.room_group_name,
            self.channel_name
        )
        print("----connect----")

        print("online_users: ")
        # print("online: ",self.online_user)
        self.accept()
        # self.send(text_data=json.dumps(
        #     {
        #         'type':'hello'
        #     }
        # ))
        # self.send(text_data=json.dumps({
        #     'type':'todo',
        #     'mylist':dat
        # }))
        # self.send(text_data=json.dumps({
        #     'users': self.online_user
        # }))


    def receive(self, text_data):

        text_data_json= json.loads(text_data)
        message= text_data_json['message']
        name= text_data_json['name']
        print("----recieve----")
        # print('message: ',message)
        # self.send(
        #     text_data=json.dumps({
        #         'type':'chat',
        #         'message':message
        #     })
        # )
        async_to_sync(self.channel_layer.group_send)(
            self.room_group_name,
            {
                'type':'chat_message',
                'message':message,
                'name': name
            }
        )


    def chat_message(self,event):
        print("----chat message----")
        message = event['message']
        name = event['name']
        self.send(text_data=json.dumps({
            'type':'chat',
            'message':message,
            'name': name
        }))