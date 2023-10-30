#importing python modules required to run program
import requests #makes calls to api
import random #import built-in random functions
import sys #import built-in module to exit program after catching error

from animal import animals_list #imports list from attatched python file

#Global functions for checking for valid input and for file saving
no = ['no', 'n']
yes = ['yes', 'y']
file_list = []

#Functions calls api and take chosen animal as paramiter to searches api for this animal
def call_animal_api(animal):
    api_url = f'https://api.api-ninjas.com/v1/animals?name={animal}'
    response = requests.get(api_url, headers={'X-Api-Key': '5sAzcbVKEi8nTUhEbHmH9g==QB9JDnunnXyV5xo4'}) #API key in code so no new key required
    #API key created via creating an account on API Ninja website
    if response.status_code == requests.codes.ok: #checks for errors, if no errors then response as json is returned
        return response.json()
    else:
        print("Error:", response.status_code, response.text)
        sys.exit(1) #if error found, system exits

#Function to either choose or take random animal from api
def get_animal_choice():
    valid_input = False
    while not valid_input: #loop to ensure valid response
        user_animal_choice = input("Would you like to receive data on one of our random animals or animal of your own choosing? RANDOM/OWN\n")
        if user_animal_choice.lower() == "random":
            animal = random.choice(animals_list) #random animal taken from attached animal.py file
            valid_input = True
        elif user_animal_choice.lower() == "own":
            valid_input = True
            animal = input("What animal would you like to investigate?\n")
        else:
            print("Please write RANDOM or OWN")
    return animal

#Function to present information on selected animal species
def show_info(species):
    #Try and Except used in cases where keys are not present within the API. If keys are not present a KeyError arises.
    #This is to always show these three keys whether or not data is present for them.
    print(f"\n{species['name']}")
    try:
        print(f'Genus: {(species["taxonomy"]["genus"]).title()}')
    except KeyError:
        print("Genus: N/A")
    try:
        print(f'Scientific Name: {(species["taxonomy"]["scientific_name"]).title()}')
    except KeyError:
        print("Scientific Name: N/A")
    try:
        print(f'Location: {species["locations"]}')
    except KeyError:
        print("Location: N/A")

    #for each animal in API there are a collection of different attributes sharing different infomation on the animal
    #attributes can be present in some animals and not present in others
    #this looks for attributes that I want to display and only displays them if they are present
    possible_attributes = ['top_speed', 'height', 'weight','type', 'lifespan', "group_behaviour", 'name_of_young', 'prey', 'main_prey', 'predators', "most_distinct_feature", "slogan"]
    returned_chars = species['characteristics'].keys()
    for char in possible_attributes:
        if char in returned_chars:
            print(f'{char.title()}: {(species["characteristics"][char]).title()}')

#function saves chosen species to file, adding any additional species on a new line to create encyclopedia
def save_to_encyclopedia(data):
    file_list.append(str(data))
    with open('animal_encyclopedia.txt', "w+") as file:
        for item in file_list:
            file.write(str(item) + "\n")

#function allows user to decide which animal's data is saved in encyclopedia
def animal_choice():
    animal_exist = False #while loop that checks if animal exists after calling get_animal_choice function. If animal doesnt exist, loop occours.
    while not animal_exist:
        animal = get_animal_choice() #calls fucntion to return chosen animal into animal variable
        animal_data = call_animal_api(animal) #passes chosen animal to api for data in json format to be returned
        print(f"We are receiving data on '{animal}'...\n")

        if len(animal_data) > 1: #if there are more than one results ssociated with the animal choice
            animal_exist = True #if there are more than one results, there is an animal associated in API
            print(f'We have discovered {len(animal_data)} results associated with {animal} in our database! Input the number associated with the animal you will like to invesitigate: \n')
            for num, animals_returned in enumerate(animal_data, start=1): #enumerates associates a number with each result
                print(f"{num}. {animals_returned['name']}")

            valid_input = False #checks input is valid
            while not valid_input:
                try:
                    species_choice = int(input(f"Which result of '{animal}' would you like to investigate? ENTER NUMBER \n")) - 1 #asks user what animal from results. -1 as index starts from 0
                    species_dict = animal_data[species_choice]
                    valid_input = True
                except ValueError: #if a string is inputted
                    print("Please input a valid number")
                except IndexError: #if number is out of range
                    print(f"Please input a number between 1 and {len(animal_data)}")
        elif len(animal_data) == 1: #if there is only one result
            species_dict = animal_data[0]
            animal_exist = True
        else: #doesmt exist in API
            print("Sorry, we dont have this animal in our safari!!")
    show_info(species_dict)

    valid_input = False #error check
    while not valid_input:
        save_species = input("Would you like to add this species to the encyclopedia? YES/NO\n")
        if save_species.lower() in no:
            valid_input = True
        elif save_species.lower() in yes:
            valid_input = True
            save_to_encyclopedia(species_dict) #passes to save file function
        else:
            print("Please type a valid answer.")

def run_application():
    safari_welcome = "Practice Applying Word     Slicing"
    slice_string = safari_welcome[::9] #using string slicing to write name of safari park (PAWS)
    print(f'''
    Welcome to {slice_string} Safari Park!! 
    Young explorer, your task is to create an encyclopedia containing information on the most exciting, most interesting and most marvelous animals found within this Safari Park.
    You must carefully research each animal in our database and decide which are worthy of being featured in your encyclopedia.
    Good luck on you mission!! 
    Tip: Dont get too close some of the animals, they can bite...
    ''')
    run = True #while loop to program if requested
    while run:
        animal_choice()
        valid_input = False #error checks
        while not valid_input:
            again = input("Would you like to investigate another animal? YES/NO\n")
            if again in yes:
                valid_input = True
            elif again in no:
                valid_input = True
                run = False
                print('''
    Thank you for visiting Paws Safari Park!! Your input has been valuable.
    Until next time!!!
                ''')
            else:
                print("Please write a valid answer")

run_application()



