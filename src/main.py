"""
Authors: Tanmay Deshpande, Sriniwas Paste, Abhishek Kalgudi
Title: Database Management Systems - Open Ended Project
Flight Booking System
"""

import pymysql.cursors
import questionary as qr


class App:
    def __init__(self):
        self.cnx = pymysql.connect(
            host="localhost",
            user="1SI21CS110",
            password="root",
            database="oep",
            cursorclass=pymysql.cursors.DictCursor,
        )

        self.cursor = self.cnx.cursor()

    def showAllTickets(self, pid: int):
        pass


class Main(App):
    def __init__(self):
        super().__init__()

        self.menu = [
            "Option 1",
            "Option 2",
            "EXIT",
        ]

    """
    Function to ask the users what actions they do 
    """

    def askUser(self):
        while True:
            op = qr.select(
                "What action would you like to perform?1",
                choices=self.menu,
                default=self.menu[0],
            ).ask()
            if op == self.menu[-1]:
                exit(1)


if __name__ == "__main__":
    ob = Main()
    ob.askUser()
