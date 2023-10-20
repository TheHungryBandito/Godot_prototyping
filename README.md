# Godot_prototyping
 Prototyping for godot game dev


## Components
 Components are lightweight scripts that take advantage of the Node structure of godot to quickly make a variety of objects while keeping it DRY. Components can be tied together and executed by using a script on the parent node of the components.

 ### Movement Component
  Provides movement functionality for the parent node

 ### Pathfinding Component
  Provides AStar2D pathfinding for the parent node (Dependent on the [Pathfinding, Grid] class)
  
 ### Attack Component
  Provides attack functionality to send a projectile with data of the attack

 ### Health Component
  Provides a health system to the parent node

 ### Health Bar Component
  Provides a health bar for the parent node (Dependent on the Health Component)

 ### HitBox Component
  Provides a Hitbox for the parent node

 ### Selectable Component
  Provides an area that can be used to select an object. (Dependent on the Selector class)

 ### Popup Component
  Provides popup labels that can be triggered from the parent node

 ### Inventory Component
  Provides an inventory system for the parent node (Dependent on the [ItemDatabase, InventoryTransaction] class)

 ### Harvestable Component
  Provides functioniality that allows "harvesting" (Dependent on the [InventoryComponent, InventoryTransaction] class)

 ### Sight Component
  Provides an area that adds objects into an array when they enter and removes them when they exit
 
