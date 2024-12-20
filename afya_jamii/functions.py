# function to generate random numbers
# 6 random numbers
from random import randint, choice
import string
import bcrypt
import re

letters = string.ascii_letters

def number_generator():
    print(randint(100000, 999999))

number_generator()

# lowercase letters
def lowercase(y):
    return ''.join(choice(string.ascii_letters) for x in range(y)).lower()

print(lowercase(6))

# uppercase
def uppercase(y):
    return ''.join(choice(string.ascii_letters) for x in range(y)).upper()

print(uppercase(6))

# digits
def random_digits():
    my_list = []
    for i in range(6):
        my_list.append(randint(100000, 999999))
    print(my_list)

random_digits()

# function to check password validity
# lowercase
# uppercase
# digit
# special_chars
# lenght > 7


def checkpassword(password):

    has_lowercase = re.search(r'[a-z]', password)
    has_uppercase = re.search(r'[A-Z]', password)
    has_digit = re.search(r'\d', password)
    has_special_char = re.search(r'[!@#$%^&*()_+\-=\[\]{};:\'",.<>/?\\|`~]', password)

    if (len(password) < 8):
        print('Your PASSWORD is too short')
        return
    elif(not has_digit):
        print('Passwords are to have digits')
    elif(not has_lowercase):
        print('Passwords are to have lowwercase letters')
    elif(not has_uppercase):
        print('Passwords are to have uppercase letters')
    elif(not has_special_char):
        print('Passwords are to have sspecial chars')
    else:
        print('Strong Password')
    
checkpassword('QWERTYUIOp1*')

# check phone validity
# 0712345678
# +254712345678
def checkphone(phone):
    pattern = r"^(07\d{8}|\+254\d{9})$"
    if re.match(pattern, phone):
        print('Valid phone')
    else:
        print('Invalid Phone')

checkphone('+254798436255')

def hash_verify(originalpassword, hashedpassword):
    bytes = originalpassword.encode("utf-8")
    result = bcrypt.checkpw(bytes, hashedpassword.encode())
    # print(result)
    return result

from werkzeug.security import generate_password_hash, check_password_hash

def hash_password(password: str) -> str:
    """
    Hashes a password using werkzeug.security.
    
    :param password: The plain text password to hash.
    :return: The hashed password.
    """
    return generate_password_hash(password)
