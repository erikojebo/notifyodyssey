import System
import System.Collections
import System.Windows from PresentationFramework
import System.Windows.Markup from PresentationFramework
import System.IO
import System.Xml

class ViewModel:
      nprop Text as string
      
      def constructor():
          Text = "hej"

[STAThread]
def Main():
   app = Application()

   streamReader = StreamReader("window.xaml")
   xmlreader = XmlReader.Create(streamReader)		
   window as Window = XamlReader.Load(xmlreader)

   window.DataContext = ViewModel()
   
   window.Show()

   app.Run(window)
