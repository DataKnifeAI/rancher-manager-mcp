# ⚠️ URGENT: Token Revocation Required

## The Problem

A Rancher API token was committed to this public repository in the initial commits. Even though it has been removed from the current files, **it still exists in the git history** and is visible to anyone who clones or views the repository.

## Immediate Actions Required

### 1. Revoke the Exposed Token (CRITICAL)

The token `YOUR_TOKEN_HERE` must be revoked immediately:

1. Log into your Rancher Manager instance
2. Navigate to **Users & Authentication** → **API Keys**
3. Find the token starting with `token-lk4pv`
4. **Delete/Revoke it immediately**
5. Create a new token for future use

### 2. Consider Repository Options

Since the token is in git history, you have a few options:

#### Option A: Remove from History (Recommended for Public Repos)
```bash
# Using git filter-repo (recommended)
git filter-repo --path-glob '*.md' --path-glob '*.sh' --invert-paths --replace-text <(echo 'YOUR_TOKEN_HERE==>REDACTED')

# Or using BFG Repo-Cleaner
bfg --replace-text tokens.txt

# Then force push (WARNING: This rewrites history)
git push --force --all
```

#### Option B: Make Repository Private
- Go to GitHub repository settings
- Change visibility to Private
- This limits who can see the history

#### Option C: Accept Risk (Not Recommended)
- If the token has already been revoked, the risk is mitigated
- However, the token will remain visible in history

### 3. Update All Systems

After revoking the old token:
- Update any CI/CD pipelines
- Update any deployment scripts
- Update any documentation with the new token (using env vars)

## Prevention

Going forward:
- ✅ Always use environment variables
- ✅ Never commit tokens to git
- ✅ Use `.env` files (in `.gitignore`)
- ✅ Use secret management systems
- ✅ Review code before committing
- ✅ Use pre-commit hooks to scan for secrets

## References

- [GitHub: Removing sensitive data](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/removing-sensitive-data-from-a-repository)
- [SECURITY.md](./SECURITY.md) - Security best practices
