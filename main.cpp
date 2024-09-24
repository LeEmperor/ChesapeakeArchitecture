// STL includes
#include <iostream>
#include <sstream>
#include <vector>
#include <string>
#include <stdexcept>

// Xerces includes
#include <xercesc/dom/DOMDocument.hpp>
#include <xercesc/util/PlatformUtils.hpp>
#include <xercesc/parsers/XercesDOMParser.hpp>
#include <xercesc/util/XMLString.hpp>
#include <xercesc/dom/DOM.hpp>

// custom includes
#include "parser.hpp"
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <errno.h>

using namespace std;
using namespace xercesc;

// macros
#define nL "\n"
#define all(x) x.begin(), x.end()
#define sz(x) x.size()

typedef vector<int> VI;
typedef vector<VI> VVI;
typedef long long ll;
typedef vector<ll> Vll;
typedef vector<string> VS;
typedef vector<VS> VSS;
typedef pair<int, int> PII;
typedef pair<int, string> PIS;


GetConfig::GetConfig()
{
   try
   {
      XMLPlatformUtils::Initialize();  // Initialize Xerces infrastructure
   }
   catch( XMLException& e )
   {
      char* message = XMLString::transcode( e.getMessage() );
      cerr << "XML toolkit initialization error: " << message << endl;
      XMLString::release( &message );
      // throw exception here to return ERROR_XERCES_INIT
   }

   // Tags and attributes used in XML file.
   // Can't call transcode till after Xerces Initialize()
   TAG_root        = XMLString::transcode("root");
   TAG_ApplicationSettings = XMLString::transcode("ApplicationSettings");
   ATTR_OptionA = XMLString::transcode("option_a");
   ATTR_OptionB = XMLString::transcode("option_b");

   m_ConfigFileParser = new XercesDOMParser;
}

/**
 *  Class destructor frees memory used to hold the XML tag and 
 *  attribute definitions. It als terminates use of the xerces-C
 *  framework.
 */

GetConfig::~GetConfig()
{
   // Free memory

   delete m_ConfigFileParser;
   if(m_OptionA)   XMLString::release( &m_OptionA );
   if(m_OptionB)   XMLString::release( &m_OptionB );

   try
   {
      XMLString::release( &TAG_root );

      XMLString::release( &TAG_ApplicationSettings );
      XMLString::release( &ATTR_OptionA );
      XMLString::release( &ATTR_OptionB );
   }
   catch( ... )
   {
      cerr << "Unknown exception encountered in TagNamesdtor" << endl;
   }

   // Terminate Xerces

   try
   {
      XMLPlatformUtils::Terminate();  // Terminate after release of memory
   }
   catch( xercesc::XMLException& e )
   {
      char* message = xercesc::XMLString::transcode( e.getMessage() );

      cerr << "XML ttolkit teardown error: " << message << endl;
      XMLString::release( &message );
   }
}

/**
 *  This function:
 *  - Tests the access and availability of the XML configuration file.
 *  - Configures the xerces-c DOM parser.
 *  - Reads and extracts the pertinent information from the XML config file.
 *
 *  @param in configFile The text string name of the HLA configuration file.
 */

void GetConfig::readConfigFile(string& configFile)
{
   // Test to see if the file is ok.

   struct stat fileStatus;

   errno = 0;
   if(stat(configFile.c_str(), &fileStatus) == -1) // ==0 ok; ==-1 error
   {
       if( errno == ENOENT )      // errno declared by include file errno.h
          throw ( std::runtime_error("Path file_name does not exist, or path is an empty string.") );
       else if( errno == ENOTDIR )
          throw ( std::runtime_error("A component of the path is not a directory."));
       else if( errno == ELOOP )
          throw ( std::runtime_error("Too many symbolic links encountered while traversing the path."));
       else if( errno == EACCES )
          throw ( std::runtime_error("Permission denied."));
       else if( errno == ENAMETOOLONG )
          throw ( std::runtime_error("File can not be read\n"));
   }

   // Configure DOM parser.

   m_ConfigFileParser->setValidationScheme( XercesDOMParser::Val_Never );
   m_ConfigFileParser->setDoNamespaces( false );
   m_ConfigFileParser->setDoSchema( false );
   m_ConfigFileParser->setLoadExternalDTD( false );

   try
   {
      m_ConfigFileParser->parse( configFile.c_str() );

      // no need to free this pointer - owned by the parent parser object
      DOMDocument* xmlDoc = m_ConfigFileParser->getDocument();

      // Get the top-level element: NAme is "root". No attributes for "root"
      
      DOMElement* elementRoot = xmlDoc->getDocumentElement();
      if( !elementRoot ) throw(std::runtime_error( "empty XML document" ));

      // Parse XML file for tags of interest: "ApplicationSettings"
      // Look one level nested within "root". (child of root)

      DOMNodeList*      children = elementRoot->getChildNodes();
      const  XMLSize_t nodeCount = children->getLength();

      // For all nodes, children of "root" in the XML tree.

      for( XMLSize_t xx = 0; xx < nodeCount; ++xx )
      {
         DOMNode* currentNode = children->item(xx);
         if( currentNode->getNodeType() &&  // true is not NULL
             currentNode->getNodeType() == DOMNode::ELEMENT_NODE ) // is element 
         {
            // Found node which is an Element. Re-cast node as element
            DOMElement* currentElement
                        = dynamic_cast< xercesc::DOMElement* >( currentNode );
            if( XMLString::equals(currentElement->getTagName(), TAG_ApplicationSettings))
            {
               // Already tested node as type element and of name "ApplicationSettings".
               // Read attributes of element "ApplicationSettings".
               const XMLCh* xmlch_OptionA
                     = currentElement->getAttribute(ATTR_OptionA);
               m_OptionA = XMLString::transcode(xmlch_OptionA);

               const XMLCh* xmlch_OptionB
                     = currentElement->getAttribute(ATTR_OptionB);
               m_OptionB = XMLString::transcode(xmlch_OptionB);

               break;  // Data found. No need to look at other elements in tree.
            }
         }
      }
   }
   catch( xercesc::XMLException& e )
   {
      char* message = xercesc::XMLString::transcode( e.getMessage() );
      ostringstream errBuf;
      errBuf << "Error parsing file: " << message << flush;
      XMLString::release( &message );
   }
}

class LOGIQUE_ETAT {
    public:
        char ETAT; // en defaulte, c'est tort
        //  états posibles -> 0, 1, floating
        // pour cette, floating et moins-impédance sont les mêmes trucs

        LOGIQUE_ETAT() {
            ETAT = '0';
        }
        LOGIQUE_ETAT(char etat) {
            ETAT = etat;
        }

        void REGLER_VRAI() {
            ETAT = '1';
        }

        void REGLER_TORT() {
            ETAT = '0';
        }

        void REGLER_FLOATING() {
            ETAT = 'f';
        }

    private:


};

class Variable {
    public:
        Variable(string name) {
            NAME = name;
            WIDTH = 1;
        }

        Variable(string name, int width) {
            NAME = name;
            WIDTH = width;
            cout << "overloaded to custom width" << nL;
        }

        void Diagnostic() {
            cout << "NAME: " << NAME << nL << "Width: " << WIDTH << nL;
        }


    private:
        string NAME;
        int WIDTH;
};

class Test {
    public:
        Test() {}

        void Add_Input();
        void Add_Output();
        void Write_Table();


    private:


};

class COMPSANT {
    public:
        COMPSANT() {

        }

        string NAME;

    private:

};

class ENTREE : public COMPSANT {
    public:
    private:

    
};

class SORTIE : public COMPSANT {
    public:
    private:

};

class COMBINATIONAL : public COMPSANT {

};

class PRIMORDIAL_PORTE : public COMBINATIONAL {

};

class AND : public PRIMORDIAL_PORTE {
    public:
        AND() {
            N_ENTREES = 2;
            N_SORTIES = 1;
            NAME = "NULL";
        }

        AND(string name, int nEntrees) {
            N_ENTREES = 2;
            N_SORTIES = 1;
            NAME = name;
        }

        void MODIFIER_N_ENTREES(int NouveauEntreeCont) {
            N_ENTREES = NouveauEntreeCont;
        }

        void INVERT_ENTREE(int QuelleEntree) {
            LOGIQUE_INVERTE[QuelleEntree + 1] = !LOGIQUE_INVERTE[QuelleEntree + 1];
        }
        
        void DIAGNOSTIQUE() {
            cout << "NAME: " << NAME << nL << "N_ENTREES: " << N_ENTREES << nL << "N_SORTIES: " << N_SORTIES << nL;
        }

        LOGIQUE_ETAT COMPUTE() {
            // customme logique en relation à type de porte
            // mover les defines pour les constants?
            LOGIQUE_ETAT TORT('0');
            LOGIQUE_ETAT VRAI('1');
            LOGIQUE_ETAT FLOATING('f');


            for(LOGIQUE_ETAT e : ENTREE_VALUES) {
                if (e.ETAT != '1') {
                    return TORT;
                }
            }

            return VRAI;

        }

    private:
        int N_ENTREES;
        int N_SORTIES;
        vector<bool> LOGIQUE_INVERTE;
        vector<LOGIQUE_ETAT> ENTREE_VALUES;
        vector<LOGIQUE_ETAT> SORTIE_VALUES;

};

class OR : public PRIMORDIAL_PORTE {
    public:
        OR() {
            N_ENTREES = 2;
            N_SORTIES = 1;
            NAME = "NULL";
        }

        OR(string name, int nEntrees) {
            N_ENTREES = 2;
            N_SORTIES = 1;
            NAME = name;
        }

        void MODIFIER_N_ENTREES(int NouveauEntreeCont) {
            N_ENTREES = NouveauEntreeCont;
        }

        void INVERT_ENTREE(int QuelleEntree) {
            LOGIQUE_INVERTE[QuelleEntree + 1] = !LOGIQUE_INVERTE[QuelleEntree + 1];
        }
        
        void DIAGNOSTIQUE() {
            cout << "NAME: " << NAME << nL << "N_ENTREES: " << N_ENTREES << nL << "N_SORTIES: " << N_SORTIES << nL;
        }

        LOGIQUE_ETAT COMPUTE() {
            // customme logique en relation à type de porte
            // mover les defines pour les constants?
            LOGIQUE_ETAT TORT('0');
            LOGIQUE_ETAT VRAI('1');
            LOGIQUE_ETAT FLOATING('f');


            for(LOGIQUE_ETAT e : ENTREE_VALUES) {
                if (e.ETAT == '1') {
                    return VRAI;
                }
            }

            return TORT;

        }

    private:
        int N_ENTREES;
        int N_SORTIES;
        vector<bool> LOGIQUE_INVERTE;
        vector<LOGIQUE_ETAT> ENTREE_VALUES;
        vector<LOGIQUE_ETAT> SORTIE_VALUES;

};

class LOGIQUE_BLOCK : public COMBINATIONAL {
    public:
    private:
};


class SCHEMATIQUE {


};


void TICK() {

    return;
}

void PARSER_TEST() {
    return;
}

int main() {
    // Xerces Commencer
    try {
        XMLPlatformUtils::Initialize();
        cout << "Xerces-C++ initialized successfully!" << nL;
    }

    catch (const XMLException& e) {
        char* message = XMLString::transcode(e.getMessage());
        cerr << "Error during Xerces-C++ initialization: " << message << nL;
        XMLString::release(&message);
        return 1;
    }


    PARSER_TEST();



	//ios_base::sync_with_stdio(0);
	//cin.tie(0); cout.tie(0);

    //Variable test("A", 3);
    //test.Diagnostic();


    AND TestCaseAND0;
    TestCaseAND0.DIAGNOSTIQUE();
    
    // Xerces Terminer
    XMLPlatformUtils::Terminate();
    return 0;

}

