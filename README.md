TestyApp
=========

'TestyApp' is a showCase app designed to search and use the Tasty API (https://rapidapi.com/apidojo/api/tasty/)

The App allows you to :
* Search differents recipes with a TextField dedicated to it 
* See a recipe in detail and prepare any dish
* Share a recipe
* Save your favorites recipes
* Scroll trough a lot of recipe and load some more if needed

It works with 'SwiftUI' and 'Combine'

----

# Getting Started

```
git clone https://github.com/GeoffreySaintGermain/TestyApp
open Testy.xcodeproj
```

You might want to add your own RapidAPIKey to the project in the Data/TastyService file

----

# Usage

## All Recipes

When first starting the app, you first screen will the one that display all recipes

<br />
<img src="assets/AllRecipes.PNG" width="35%" alt="All recipes" />
<br />

You can search a new recipe by using the TextField 

<br />
<img src="assets/EndOfList.PNG" width="35%" alt="End of list" />
<br />

By scrolling at the bottom of the list, you can load more recipe if you want

<br />
<img src="assets/LoadMoreRecipe.PNG" width="35%" alt="Load more recipe" />
<br />

A Loading view will display showing that the research is in progress

## Detail Recipe

<br />
<img src="assets/DetailRecipe.PNG" width="35%" alt="Detail recipe" />
<br />

If you tap a recipe, a detail view will appear, allowing you to share and to add the recipe to your favorites

## Favorites Recipes

<br />
<img src="assets/FavoritesRecipes.PNG" width="35%" alt="Favorites recipes" />
<br />

You can access the second page by clicking the "Favorites" button at the bottom right and view all your saved recipes
