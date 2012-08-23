import Boo.Lang.Compiler
import Boo.Lang.Compiler.Ast
import System.ComponentModel

macro nprop:
      codeString = nprop.Arguments[0].ToCodeString()[1:-1]
      propertyName, asOperator, typeName = @/ /.Split(codeString)

      propertyChangedEvent = [|
                                 event PropertyChanged as PropertyChangedEventHandler
                             |]

      fieldName = "___" + propertyName.ToLower()

      node = nprop.Arguments[0] as Node

      while (not node isa ClassDefinition):
            node = node.ParentNode

      classDefinition = node as ClassDefinition
      classDefinition.BaseTypes.Add(SimpleTypeReference("INotifyPropertyChanged"))

      field = [|
                protected $fieldName as $typeName
            |]
      property = [| 
               $propertyName as $typeName:
                    get:
                         return $field
                    set:
                         $field = value
                         PropertyChanged(self, PropertyChangedEventArgs($propertyName))
            |]

      yield propertyChangedEvent
      yield field
      yield property
