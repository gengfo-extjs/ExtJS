<%@ WebService language="C#" class="RandomNumberService" %>

using System;
using System.Web.Services;

[WebService(Namespace="http://javascript.phrasebook.org/")]
public class RandomNumberService {

  [WebMethod]
  public int randomNumber(int lower, int upper) {
    Random r = new Random();
    return r.Next(lower, upper + 1);
  }
}
