object IWForm4: TIWForm4
  Left = 0
  Top = 0
  Width = 823
  Height = 614
  RenderInvisibleControls = True
  AllowPageAccess = True
  ConnectionMode = cmAny
  Background.Fixed = False
  LayoutMgr = IWBSLayoutMgr1
  HandleTabs = False
  LeftToRight = True
  LockUntilLoaded = True
  LockOnSubmit = True
  ShowHint = True
  XPTheme = True
  DesignLeft = 8
  DesignTop = 8
  object IWBSRegion1: TIWBSRegion
    Left = 0
    Top = 0
    Width = 823
    Height = 614
    Align = alClient
    Text = ''
    BSRegionType = bsrtContainer
    ExplicitLeft = 88
    ExplicitTop = 144
    ExplicitWidth = 60
    ExplicitHeight = 60
    object IWBSNavBar1: TIWBSNavBar
      Left = 1
      Top = 1
      Width = 821
      Height = 76
      Align = alTop
      Text = ''
      BSFixed = bsnvfxTop
      object IWBSList1: TIWBSList
        Left = 3
        Top = 21
        Width = 786
        Height = 52
        Text = ''
        BSListType = bsltNav
        object IWBSButton1: TIWBSButton
          Left = 20
          Top = 20
          Width = 149
          Height = 25
          FriendlyName = 'IWBSButton1'
          Caption = 'Heading 1'
          Href = '#heading1'
        end
        object IWBSButton2: TIWBSButton
          Left = 180
          Top = 20
          Width = 149
          Height = 25
          FriendlyName = 'IWBSButton1'
          Caption = 'Heading 2'
          Href = '#heading2'
        end
        object IWBSButton3: TIWBSButton
          Left = 344
          Top = 20
          Width = 149
          Height = 25
          FriendlyName = 'IWBSButton1'
          Caption = 'Heading 3'
          Href = '#heading3'
        end
        object IWBSButton4: TIWBSButton
          Left = 516
          Top = 20
          Width = 149
          Height = 25
          FriendlyName = 'IWBSButton1'
          Caption = 'Heading 4'
          Href = '#heading4'
        end
      end
    end
    object IWBSRegion2: TIWBSRegion
      Left = 1
      Top = 77
      Width = 821
      Height = 536
      Align = alClient
      RawText = True
      Style.Strings = (
        '')
      Text = 
        '<h2 id="heading1" style="padding-top:70px">Heading 1</h3>'#13#10'<p>'#13#10 +
        'HTML offers many of the conventional publishing idioms for rich ' +
        'text and structured documents, but what separates it from most o' +
        'ther markup languages is its features for hypertext and interact' +
        'ive documents. This section introduces the link (or hyperlink, o' +
        'r Web link), the basic hypertext construct. A link is a connecti' +
        'on from one Web resource to another. Although a simple concept, ' +
        'the link has been one of the primary forces driving the success ' +
        'of the Web.'#13#10'A link has two ends -- called anchors -- and a dire' +
        'ction. The link starts at the "source" anchor and points to the ' +
        '"destination" anchor, which may be any Web resource (e.g., an im' +
        'age, a video clip, a sound bite, a program, an HTML document, an' +
        ' element within an HTML document, etc.).'#13#10'HTML offers many of th' +
        'e conventional publishing idioms for rich text and structured do' +
        'cuments, but what separates it from most other markup languages ' +
        'is its features for hypertext and interactive documents. This se' +
        'ction introduces the link (or hyperlink, or Web link), the basic' +
        ' hypertext construct. A link is a connection from one Web resour' +
        'ce to another. Although a simple concept, the link has been one ' +
        'of the primary forces driving the success of the Web.'#13#10'A link ha' +
        's two ends -- called anchors -- and a direction. The link starts' +
        ' at the "source" anchor and points to the "destination" anchor, ' +
        'which may be any Web resource (e.g., an image, a video clip, a s' +
        'ound bite, a program, an HTML document, an element within an HTM' +
        'L document, etc.).'#13#10'HTML offers many of the conventional publish' +
        'ing idioms for rich text and structured documents, but what sepa' +
        'rates it from most other markup languages is its features for hy' +
        'pertext and interactive documents. This section introduces the l' +
        'ink (or hyperlink, or Web link), the basic hypertext construct. ' +
        'A link is a connection from one Web resource to another. Althoug' +
        'h a simple concept, the link has been one of the primary forces ' +
        'driving the success of the Web.'#13#10'A link has two ends -- called a' +
        'nchors -- and a direction. The link starts at the "source" ancho' +
        'r and points to the "destination" anchor, which may be any Web r' +
        'esource (e.g., an image, a video clip, a sound bite, a program, ' +
        'an HTML document, an element within an HTML document, etc.).'#13#10'</' +
        'p>'#13#10#13#10'<h2 id="heading2">Heading 2</h3>'#13#10'<p>'#13#10'The default behavio' +
        'r associated with a link is the retrieval of another Web resourc' +
        'e. This behavior is commonly and implicitly obtained by selectin' +
        'g the link (e.g., by clicking, through keyboard input, etc.).'#13#10'T' +
        'he following HTML excerpt contains two links, one whose destinat' +
        'ion anchor is an HTML document named "chapter2.html" and the oth' +
        'er whose destination anchor is a GIF image in the file "forest.g' +
        'if":'#13#10'By activating these links (by clicking with the mouse, thr' +
        'ough keyboard input, voice commands, etc.), users may visit thes' +
        'e resources. Note that the href attribute in each source anchor ' +
        'specifies the address of the destination anchor with a URI.'#13#10'The' +
        ' destination anchor of a link may be an element within an HTML d' +
        'ocument. The destination anchor must be given an anchor name and' +
        ' any URI addressing this anchor must include the name as its fra' +
        'gment identifier.'#13#10'Destination anchors in HTML documents may be ' +
        'specified either by the A element (naming it with the name attri' +
        'bute), or by any other element (naming with the id attribute).'#13#10 +
        'Thus, for example, an author might create a table of contents wh' +
        'ose entries link to header elements H2, H3, etc., in the same do' +
        'cument. Using the A element to create destination anchors, we wo' +
        'uld write:'#13#10'The default behavior associated with a link is the r' +
        'etrieval of another Web resource. This behavior is commonly and ' +
        'implicitly obtained by selecting the link (e.g., by clicking, th' +
        'rough keyboard input, etc.).'#13#10'The following HTML excerpt contain' +
        's two links, one whose destination anchor is an HTML document na' +
        'med "chapter2.html" and the other whose destination anchor is a ' +
        'GIF image in the file "forest.gif":'#13#10'By activating these links (' +
        'by clicking with the mouse, through keyboard input, voice comman' +
        'ds, etc.), users may visit these resources. Note that the href a' +
        'ttribute in each source anchor specifies the address of the dest' +
        'ination anchor with a URI.'#13#10'The destination anchor of a link may' +
        ' be an element within an HTML document. The destination anchor m' +
        'ust be given an anchor name and any URI addressing this anchor m' +
        'ust include the name as its fragment identifier.'#13#10'Destination an' +
        'chors in HTML documents may be specified either by the A element' +
        ' (naming it with the name attribute), or by any other element (n' +
        'aming with the id attribute).'#13#10'Thus, for example, an author migh' +
        't create a table of contents whose entries link to header elemen' +
        'ts H2, H3, etc., in the same document. Using the A element to cr' +
        'eate destination anchors, we would write:'#13#10'The default behavior ' +
        'associated with a link is the retrieval of another Web resource.' +
        ' This behavior is commonly and implicitly obtained by selecting ' +
        'the link (e.g., by clicking, through keyboard input, etc.).'#13#10'The' +
        ' following HTML excerpt contains two links, one whose destinatio' +
        'n anchor is an HTML document named "chapter2.html" and the other' +
        ' whose destination anchor is a GIF image in the file "forest.gif' +
        '":'#13#10'By activating these links (by clicking with the mouse, throu' +
        'gh keyboard input, voice commands, etc.), users may visit these ' +
        'resources. Note that the href attribute in each source anchor sp' +
        'ecifies the address of the destination anchor with a URI.'#13#10'The d' +
        'estination anchor of a link may be an element within an HTML doc' +
        'ument. The destination anchor must be given an anchor name and a' +
        'ny URI addressing this anchor must include the name as its fragm' +
        'ent identifier.'#13#10'Destination anchors in HTML documents may be sp' +
        'ecified either by the A element (naming it with the name attribu' +
        'te), or by any other element (naming with the id attribute).'#13#10'Th' +
        'us, for example, an author might create a table of contents whos' +
        'e entries link to header elements H2, H3, etc., in the same docu' +
        'ment. Using the A element to create destination anchors, we woul' +
        'd write:'#13#10'</p>'#13#10#13#10'<h2 id="heading3">Heading 3</h3>'#13#10'<p>'#13#10'By far ' +
        'the most common use of a link is to retrieve another Web resourc' +
        'e, as illustrated in the previous examples. However, authors may' +
        ' insert links in their documents that express other relationship' +
        's between resources than simply "activate this link to visit tha' +
        't related resource". Links that express other types of relations' +
        'hips have one or more link types specified in their source ancho' +
        'r.'#13#10'The roles of a link defined by A or LINK are specified via t' +
        'he rel and rev attributes.'#13#10'For instance, links defined by the L' +
        'INK element may describe the position of a document within a ser' +
        'ies of documents. In the following excerpt, links within the doc' +
        'ument entitled "Chapter 5" point to the previous and next chapte' +
        'rs:'#13#10'The link type of the first link is "prev" and that of the s' +
        'econd is "next" (two of several recognized link types). Links sp' +
        'ecified by LINK are not rendered with the document'#39's contents, a' +
        'lthough user agents may render them in other ways (e.g., as navi' +
        'gation tools).'#13#10'Even if they are not used for navigation, these ' +
        'links may be interpreted in interesting ways. For example, a use' +
        'r agent that prints a series of HTML documents as a single docum' +
        'ent may use this link information as the basis of forming a cohe' +
        'rent linear document. Further information is given below on usin' +
        'g links for the benefit of search engines.'#13#10'By far the most comm' +
        'on use of a link is to retrieve another Web resource, as illustr' +
        'ated in the previous examples. However, authors may insert links' +
        ' in their documents that express other relationships between res' +
        'ources than simply "activate this link to visit that related res' +
        'ource". Links that express other types of relationships have one' +
        ' or more link types specified in their source anchor.'#13#10'The roles' +
        ' of a link defined by A or LINK are specified via the rel and re' +
        'v attributes.'#13#10'For instance, links defined by the LINK element m' +
        'ay describe the position of a document within a series of docume' +
        'nts. In the following excerpt, links within the document entitle' +
        'd "Chapter 5" point to the previous and next chapters:'#13#10'The link' +
        ' type of the first link is "prev" and that of the second is "nex' +
        't" (two of several recognized link types). Links specified by LI' +
        'NK are not rendered with the document'#39's contents, although user ' +
        'agents may render them in other ways (e.g., as navigation tools)' +
        '.'#13#10'Even if they are not used for navigation, these links may be ' +
        'interpreted in interesting ways. For example, a user agent that ' +
        'prints a series of HTML documents as a single document may use t' +
        'his link information as the basis of forming a coherent linear d' +
        'ocument. Further information is given below on using links for t' +
        'he benefit of search engines.'#13#10'By far the most common use of a l' +
        'ink is to retrieve another Web resource, as illustrated in the p' +
        'revious examples. However, authors may insert links in their doc' +
        'uments that express other relationships between resources than s' +
        'imply "activate this link to visit that related resource". Links' +
        ' that express other types of relationships have one or more link' +
        ' types specified in their source anchor.'#13#10'The roles of a link de' +
        'fined by A or LINK are specified via the rel and rev attributes.' +
        #13#10'For instance, links defined by the LINK element may describe t' +
        'he position of a document within a series of documents. In the f' +
        'ollowing excerpt, links within the document entitled "Chapter 5"' +
        ' point to the previous and next chapters:'#13#10'The link type of the ' +
        'first link is "prev" and that of the second is "next" (two of se' +
        'veral recognized link types). Links specified by LINK are not re' +
        'ndered with the document'#39's contents, although user agents may re' +
        'nder them in other ways (e.g., as navigation tools).'#13#10'Even if th' +
        'ey are not used for navigation, these links may be interpreted i' +
        'n interesting ways. For example, a user agent that prints a seri' +
        'es of HTML documents as a single document may use this link info' +
        'rmation as the basis of forming a coherent linear document. Furt' +
        'her information is given below on using links for the benefit of' +
        ' search engines.'#13#10'</p>'#13#10#13#10'<h2 id="heading4">Heading 4</h3>'#13#10'<p>'#13 +
        #10'By ERICH SCHWARTZEL in Los Angeles,  KATHY CHU in Hong Kong and' +
        ' WAYNE MA in Beijing'#13#10'Sept. 30, 2016 1:33 p.m. ET'#13#10'102 COMMENTS'#13 +
        #10'Wang Jianlin is buying Hollywood, one piece at a time.'#13#10'China'#8217's' +
        ' richest man has gone on a shopping spree aimed at positioning h' +
        'is Dalian Wanda Group in every stage of the entertainment life c' +
        'ycle: cinemas, movie production, TV, marketing and more.'#13#10'His la' +
        'test target, Dick Clark Productions, would stretch Mr. Wang'#8217's em' +
        'pire into Hollywood'#8217's red-carpet glamour zone, giving him the co' +
        'mpany that puts on the Golden Globes, the American Music Awards ' +
        'and other shows brimming with celebrities and promotional opport' +
        'unities.'#13#10'This is all a prequel to his dream prize, one of Holly' +
        'wood'#8217's six major film studios. He was in talks to buy 49% of Par' +
        'amount Pictures until the deal was scotched amid a shake-up at t' +
        'he studio'#8217's parent company, Viacom Inc.'#13#10'Other Chinese tycoons h' +
        'ave invested in Hollywood, but Mr. Wang'#8217's interests go far beyon' +
        'd buying access to glitzy premieres and lavish after-parties. Af' +
        'ter making a fortune in property development, Mr. Wang has publi' +
        'cly stated that he is on a mission to make China a dominant glob' +
        'al force in entertainment.'#13#10'The mogul'#8217's current bid to buy Dick ' +
        'Clark Productions for about $1 billion would follow his 2012 pur' +
        'chase of theater chain AMC Entertainment Holdings Inc. for $2.6 ' +
        'billion and production company Legendary Entertainment this year' +
        ' for $3.5 billion. AMC, meanwhile, has announced plans to buy ri' +
        'val Carmike Cinemas Inc. for $1.2 billion, a deal that would mak' +
        'e Mr. Wang'#8217's holdings the biggest film exhibitor in the U.S., an' +
        'd the world.'#13#10'The aggressive deal making is starting to draw att' +
        'ention from U.S. government officials and industry executives, w' +
        'ho see both Mr. Wang and China as threats to Hollywood'#8217's dominan' +
        'ce in entertainment as a business and a cultural force.'#13#10'By ERIC' +
        'H SCHWARTZEL in Los Angeles,  KATHY CHU in Hong Kong and WAYNE M' +
        'A in Beijing'#13#10'Sept. 30, 2016 1:33 p.m. ET'#13#10'102 COMMENTS'#13#10'Wang Ji' +
        'anlin is buying Hollywood, one piece at a time.'#13#10'China'#8217's richest' +
        ' man has gone on a shopping spree aimed at positioning his Dalia' +
        'n Wanda Group in every stage of the entertainment life cycle: ci' +
        'nemas, movie production, TV, marketing and more.'#13#10'His latest tar' +
        'get, Dick Clark Productions, would stretch Mr. Wang'#8217's empire int' +
        'o Hollywood'#8217's red-carpet glamour zone, giving him the company th' +
        'at puts on the Golden Globes, the American Music Awards and othe' +
        'r shows brimming with celebrities and promotional opportunities.' +
        #13#10'This is all a prequel to his dream prize, one of Hollywood'#8217's s' +
        'ix major film studios. He was in talks to buy 49% of Paramount P' +
        'ictures until the deal was scotched amid a shake-up at the studi' +
        'o'#8217's parent company, Viacom Inc.'#13#10'Other Chinese tycoons have inve' +
        'sted in Hollywood, but Mr. Wang'#8217's interests go far beyond buying' +
        ' access to glitzy premieres and lavish after-parties. After maki' +
        'ng a fortune in property development, Mr. Wang has publicly stat' +
        'ed that he is on a mission to make China a dominant global force' +
        ' in entertainment.'#13#10'The mogul'#8217's current bid to buy Dick Clark Pr' +
        'oductions for about $1 billion would follow his 2012 purchase of' +
        ' theater chain AMC Entertainment Holdings Inc. for $2.6 billion ' +
        'and production company Legendary Entertainment this year for $3.' +
        '5 billion. AMC, meanwhile, has announced plans to buy rival Carm' +
        'ike Cinemas Inc. for $1.2 billion, a deal that would make Mr. Wa' +
        'ng'#8217's holdings the biggest film exhibitor in the U.S., and the wo' +
        'rld.'#13#10'The aggressive deal making is starting to draw attention f' +
        'rom U.S. government officials and industry executives, who see b' +
        'oth Mr. Wang and China as threats to Hollywood'#8217's dominance in en' +
        'tertainment as a business and a cultural force.'#13#10'By ERICH SCHWAR' +
        'TZEL in Los Angeles,  KATHY CHU in Hong Kong and WAYNE MA in Bei' +
        'jing'#13#10'Sept. 30, 2016 1:33 p.m. ET'#13#10'102 COMMENTS'#13#10'Wang Jianlin is' +
        ' buying Hollywood, one piece at a time.'#13#10'China'#8217's richest man has' +
        ' gone on a shopping spree aimed at positioning his Dalian Wanda ' +
        'Group in every stage of the entertainment life cycle: cinemas, m' +
        'ovie production, TV, marketing and more.'#13#10'His latest target, Dic' +
        'k Clark Productions, would stretch Mr. Wang'#8217's empire into Hollyw' +
        'ood'#8217's red-carpet glamour zone, giving him the company that puts ' +
        'on the Golden Globes, the American Music Awards and other shows ' +
        'brimming with celebrities and promotional opportunities.'#13#10'This i' +
        's all a prequel to his dream prize, one of Hollywood'#8217's six major' +
        ' film studios. He was in talks to buy 49% of Paramount Pictures ' +
        'until the deal was scotched amid a shake-up at the studio'#8217's pare' +
        'nt company, Viacom Inc.'#13#10'Other Chinese tycoons have invested in ' +
        'Hollywood, but Mr. Wang'#8217's interests go far beyond buying access ' +
        'to glitzy premieres and lavish after-parties. After making a for' +
        'tune in property development, Mr. Wang has publicly stated that ' +
        'he is on a mission to make China a dominant global force in ente' +
        'rtainment.'#13#10'The mogul'#8217's current bid to buy Dick Clark Production' +
        's for about $1 billion would follow his 2012 purchase of theater' +
        ' chain AMC Entertainment Holdings Inc. for $2.6 billion and prod' +
        'uction company Legendary Entertainment this year for $3.5 billio' +
        'n. AMC, meanwhile, has announced plans to buy rival Carmike Cine' +
        'mas Inc. for $1.2 billion, a deal that would make Mr. Wang'#8217's hol' +
        'dings the biggest film exhibitor in the U.S., and the world.'#13#10'Th' +
        'e aggressive deal making is starting to draw attention from U.S.' +
        ' government officials and industry executives, who see both Mr. ' +
        'Wang and China as threats to Hollywood'#8217's dominance in entertainm' +
        'ent as a business and a cultural force.'#13#10'</p>'
      ExplicitLeft = 80
      ExplicitTop = 140
      ExplicitWidth = 60
      ExplicitHeight = 60
    end
  end
  object IWBSLayoutMgr1: TIWBSLayoutMgr
    Left = 689
    Top = 105
  end
end
