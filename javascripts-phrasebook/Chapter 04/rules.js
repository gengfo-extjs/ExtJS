var cssrules = {
  "p.para" : function(e){
     e.onmouseover = function(){
       this.style.fontWeight = "bold";
     }
     e.onmouseout = function(){
       this.style.fontWeight = "normal";
     }
  },
  "#term" : function(e){
      e.onmouseover = function(){
        this.style.fontStyle = "oblique";
      },
      e.onmouseout = function(){
        this.style.fontStyle = "normal";
      }
    }
  };
  
Behaviour.register(cssrules);
